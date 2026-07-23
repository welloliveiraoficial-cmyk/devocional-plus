import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
        content: Text(
          'Uma nova versão (${info.latestVersion}) do Devocional+ está pronta para baixar.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Depois'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final uri = Uri.parse(info.downloadUrl);
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            },
            child: const Text('Atualizar agora'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
