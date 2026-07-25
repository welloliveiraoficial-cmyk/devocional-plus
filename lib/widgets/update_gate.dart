import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app_installer/flutter_app_installer.dart';
import '../services/update_checker.dart';
import '../theme/app_theme.dart';

class UpdateGate extends StatefulWidget {
  final Widget child;
  const UpdateGate({super.key, required this.child});

  @override
  State<UpdateGate> createState() => _UpdateGateState();
}

class _UpdateGateState extends State<UpdateGate> with WidgetsBindingObserver {
  UpdateInfo? _blockingUpdate;
  bool _downloading = false;
  double _progress = 0;
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkUpdate());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _blockingUpdate == null) {
      _checkUpdate();
    }
  }

  Future<void> _checkUpdate() async {
    if (_checking || _blockingUpdate != null) return;
    _checking = true;

    await Future.delayed(const Duration(seconds: 5));
    final info = await UpdateChecker.check();

    _checking = false;
    if (!mounted) return;
    if (info != null && info.hasUpdate) {
      setState(() => _blockingUpdate = info);
    }
  }

  Future<void> _downloadAndInstall(String url) async {
    setState(() {
      _downloading = true;
      _progress = 0;
    });

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
        if (total > 0) {
          setState(() => _progress = received / total);
        }
        return chunk;
      }).pipe(sink);

      await sink.close();

      final installer = FlutterAppInstaller();
      await installer.installApk(filePath: file.path);

      setState(() => _downloading = false);
    } catch (e) {
      setState(() => _downloading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 20),
            content: Text('ERRO NO DOWNLOAD: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_blockingUpdate == null) {
      return widget.child;
    }

    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.system_update_rounded, color: Colors.white, size: 56),
                const SizedBox(height: 24),
                const Text(
                  'Nova versão disponível',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Para continuar usando o Devocional+, atualize para a versão ${_blockingUpdate!.latestVersion}.',
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                if (_downloading) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: _progress > 0 ? _progress : null,
                      minHeight: 8,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation(AppColors.bronze),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _progress > 0 ? '${(_progress * 100).toStringAsFixed(0)}%' : 'Iniciando download...',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ] else
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.bronze,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    ),
                    onPressed: () => _downloadAndInstall(_blockingUpdate!.downloadUrl),
                    child: const Text('Atualizar agora'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
