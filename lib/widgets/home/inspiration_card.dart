import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';

class InspirationCard extends StatefulWidget {
  const InspirationCard({super.key});

  @override
  State<InspirationCard> createState() => _InspirationCardState();
}

class _InspirationCardState extends State<InspirationCard> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        margin: const EdgeInsets.fromLTRB(22, 24, 22, 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.parchment, Color(0xFFFBF8F0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: AppColors.goldSoft),
        ),
        child: Column(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.favorite_rounded, color: AppColors.gold, size: 22),
            ),
            const SizedBox(height: 18),
            Text(
              '"A oração não muda Deus, mas transforma o coração de quem ora."',
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(color: AppColors.ink, fontSize: 15, height: 1.5, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Text('Reflexão diária', style: TextStyle(color: AppColors.inkLight, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
