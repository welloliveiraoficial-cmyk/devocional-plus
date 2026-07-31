import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DailyVerseScreen extends StatelessWidget {
  const DailyVerseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        title: const Text(
          'Versículo do Dia',
        ),
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.10),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.menu_book_rounded,
                  color: Colors.white,
                  size: 55,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Versículo do Dia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  '"Entrega o teu caminho ao Senhor; confia nele, e ele tudo fará."',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Salmos 37:5',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 24),

                const Divider(
                  color: Colors.white24,
                ),

                const SizedBox(height: 16),

                const Text(
                  'Reflexão: Confie seus planos a Deus e permita que Ele guie cada passo da sua jornada.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
