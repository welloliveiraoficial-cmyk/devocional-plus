import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../theme/app_decorations.dart';

class DailyVerseCard extends StatefulWidget {
  const DailyVerseCard({super.key});

  @override
  State<DailyVerseCard> createState() => _DailyVerseCardState();
}

class _DailyVerseCardState extends State<DailyVerseCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 700), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _message(String text) {
    AppHaptics.tap();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.96, end: 1).animate(_animation),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(22, 24, 22, 0),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withOpacity(0.2), blurRadius: 22, offset: const Offset(0, 12)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GoldenGlow(
                        size: 56,
                        opacity: 0.4,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.16), shape: BoxShape.circle),
                          child: const Icon(Icons.menu_book_rounded, color: AppColors.goldBright, size: 20),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'VERSÍCULO DO DIA',
                        style: TextStyle(color: AppColors.goldSoft, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text(
                    '"Tudo posso naquele que me fortalece."',
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 19,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Filipenses 4:13', style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 13)),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      _ActionButton(icon: Icons.favorite_border, onTap: () => _message('Versículo salvo ❤️')),
                      const SizedBox(width: 12),
                      _ActionButton(icon: Icons.share_outlined, onTap: () => _message('Compartilhar em breve 📤')),
                      const SizedBox(width: 12),
                      _ActionButton(icon: Icons.copy_outlined, onTap: () => _message('Copiado 📋')),
                    ],
                  ),
                ],
              ),
            ),
            const Positioned(top: 12, right: 34, child: BibleRibbon()),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _ActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
