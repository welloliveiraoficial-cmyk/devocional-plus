import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app_installer/flutter_app_installer.dart';
import '../services/update_checker.dart';

class UpdateGate extends StatefulWidget {
  final Widget child;
  const UpdateGate({super.key, required this.child});

  @override
  State<UpdateGate> createState() => _UpdateGateState();
}

class _UpdateGateState extends State<UpdateGate> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkUpdate());
  }

  Future<void> _checkUpdate() async {
    final info = await UpdateChecker.check();
    if (info == null || !info.hasUpdate) return;
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Nova versão disponível'),
        content: Text('Uma nova versão (${info.latestVersion}) do Devocional+ está pronta para baixar.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Depois'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              _downloadAndInstall(info.downloadUrl);
            },
            child: const Text('Atualizar agora'),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadAndInstall(String url) async {
    final progressNotifier = ValueNotifier<double>(0);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Baixando atualização'),
        content: ValueListenableBuilder<double>(
          valueListenable: progressNotifier,
          builder: (context, value, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(value: value > 0 ? value : null),
              const SizedBox(height: 12),
              Text(value > 0 ? '${(value * 100).toStringAsFixed(0)}%' : 'Iniciando...'),
            ],
          ),
        ),
      ),
    );

    try {
      final request = http.Request('GET', Uri.parse(url));
      final response = await http.Client().send(request);
      final total = response.contentLength ?? 0;

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/devocional-plus-update.apk');
      final sink = file.openWrite();

      int received = 0;
      await response.stream.map((chunk) {
        received += chunk.length;
        if (total > 0) progressNotifier.value = received / total;
        return chunk;
      }).pipe(sink);

      await sink.close();

      if (mounted) Navigator.of(context, rootNavigator: true).pop();

      final installer = FlutterAppInstaller();
      await installer.installApk(filePath: file.path);
    } catch (e) {
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível baixar a atualização. Tente novamente.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
