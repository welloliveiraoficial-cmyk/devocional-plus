import 'package:flutter/material.dart';

void main() {
  runApp(const DevocionalPlusApp());
}

class DevocionalPlusApp extends StatelessWidget {
  const DevocionalPlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devocional+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF16273F),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F5F2),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16273F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 78,
              height: 78,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  colors: [Color(0xFFC4A883), Color(0xFF9C7A5C), Color(0xFF6E5640)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(Icons.menu_book_rounded, color: Color(0xFF16273F), size: 34),
            ),
            const SizedBox(height: 22),
            const Text(
              'Devocional+',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '"Aproxime-se de Deus todos os dias."',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devocional+'),
        backgroundColor: const Color(0xFF16273F),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          'Bem-vindo ao Devocional+ 🙏\n(Estrutura inicial funcionando)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
