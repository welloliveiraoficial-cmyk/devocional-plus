import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
      _loading = false;
    });
  }

  Future<void> _toggle(bool value) async {
    setState(() => _notificationsEnabled = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);

    if (value) {
      await NotificationService.requestPermission();
      await NotificationService.scheduleDailyNotifications();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notificações diárias ativadas 🙏')),
        );
      }
    } else {
      await NotificationService.cancelAll();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notificações desativadas')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                SwitchListTile(
                  title: const Text('Notificações diárias'),
                  subtitle: const Text('Versículo do dia, frases e lembretes de oração (7h, 12h, 18h e 21h)'),
                  value: _notificationsEnabled,
                  activeColor: AppColors.bronze,
                  onChanged: _toggle,
                ),
              ],
            ),
    );
  }
}
