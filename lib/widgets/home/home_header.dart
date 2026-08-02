import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../theme/app_decorations.dart';

class HomeHeader extends StatefulWidget {
  final String saudacao;

  const HomeHeader({super.key, required this.saudacao});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> with SingleTickerProviderStateMixin {
  late AnimationController _entryController;
  late Animation<double> _entryAnimation;

  bool get isDay {
    final hour = DateTime.now().hour;
    return hour >= 6 && hour < 18;
  }

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _entryAnimation = CurvedAnimation(parent: _entryController, curve: Curves.easeOut);
    _entryController.forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _entryAnimation,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, -0.08), end: Offset.zero).animate(_entryAnimation),
        child: Container(
          padding: const EdgeInsets.fromLTRB(22, 55, 22, 30),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.saudacao,
                style: const TextStyle(
                  color: AppColors.goldSoft,
                  fontSize: 13,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Que a presença de Deus esteja com você hoje.',
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontSize: 23,
                  height: 1.3,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.gold.withOpacity(0.35), width: 0.8),
                ),
                child: Row(
                  children: [
                    GoldenGlow(
                      size: 60,
                      opacity: 0.35,
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: AppColors.gold.withOpacity(0.16),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isDay ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                          color: AppColors.goldBright,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Text(
                        'Comece seu dia com fé, oração e uma palavra de esperança.',
                        style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
