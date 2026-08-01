import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();

  runApp(const DevocionalPlusApp());
}

class DevocionalPlusApp extends StatelessWidget {
  const DevocionalPlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devocional+',
      debugShowCheckedModeBanner: false,
      navigatorKey: NotificationService.navigatorKey,
      theme: buildAppTheme(),
      home: const SplashScreen(),
    );
  }
}
