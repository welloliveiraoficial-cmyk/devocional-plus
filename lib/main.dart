import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'widgets/update_gate.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();

  runApp(
    const DevocionalPlusApp(),
  );
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

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 1800,
      ),
      vsync: this,
    );

    _logoAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _textAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.35,
        1,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();

    _setupNotifications();

    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {

        if (mounted) {

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) =>
                  const UpdateGate(
                    child: HomeScreen(),
                  ),
            ),
          );

        }

      },
    );
  }

  Future<void> _setupNotifications() async {

    await NotificationService.requestPermission();

    await NotificationService.scheduleDailyNotifications();

  }

  @override
  void dispose() {

    _controller.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.navy,

      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            ScaleTransition(
              scale: _logoAnimation,

              child: Container(
                width: 150,
                height: 150,

                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(30),

                  boxShadow: [
                    BoxShadow(
                      color: AppColors.bronze
                          .withOpacity(0.35),

                      blurRadius: 35,

                      spreadRadius: 5,
                    ),
                  ],
                ),

                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(30),

                  child: Image.asset(
                    'assets/images/logo.png',

                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),


            const SizedBox(
              height: 30,
            ),


            FadeTransition(
              opacity: _textAnimation,

              child: Column(
                children: [

                  const Text(
                    'Devocional+',

                    style: TextStyle(
                      color: Colors.white,

                      fontSize: 32,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),


                  const SizedBox(
                    height: 12,
                  ),


                  Text(
                    'Aproxime-se de Deus todos os dias.',

                    style: TextStyle(
                      color: Colors.white
                          .withOpacity(0.65),

                      fontSize: 14,

                      fontStyle:
                          FontStyle.italic,
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
