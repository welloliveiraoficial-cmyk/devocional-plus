import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_theme.dart';

/// Vibração sutil, usada em botões e toques importantes.
class AppHaptics {
  static void tap() => HapticFeedback.lightImpact();
  static void select() => HapticFeedback.selectionClick();
}

/// Brilho dourado suave atrás de um ícone/elemento — "luz das escrituras".
class GoldenGlow extends StatelessWidget {
  final Widget child;
  final double size;
  final double opacity;

  const GoldenGlow({
    super.key,
    required this.child,
    this.size = 90,
    this.opacity = 0.55,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.goldBright.withOpacity(opacity),
                AppColors.goldBright.withOpacity(0),
              ],
            ),
          ),
        ),
        child,
      ],
    );
  }
}

/// Linha dourada fina com leve resplendor, usada abaixo de títulos de seção.
class GoldenDivider extends StatelessWidget {
  final double width;

  const GoldenDivider({super.key, this.width = 44});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        gradient: const LinearGradient(
          colors: [AppColors.gold, AppColors.goldBright],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withOpacity(0.5),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}

/// Título de seção padronizado (label + linha dourada), usado em todas as telas.
class SectionHeading extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;

  const SectionHeading(
    this.text, {
    super.key,
    this.padding = const EdgeInsets.fromLTRB(22, 24, 22, 10),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 6),
          const GoldenDivider(),
        ],
      ),
    );
  }
}

/// Fita marcadora de bíblia — detalhe decorativo no canto de cards importantes.
class BibleRibbon extends StatelessWidget {
  const BibleRibbon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -2,
      right: 22,
      child: Container(
        width: 14,
        height: 34,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.goldBright, AppColors.gold],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(3),
            bottomRight: Radius.circular(3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: CustomPaint(painter: _RibbonNotchPainter()),
      ),
    );
  }
}

class _RibbonNotchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.background;
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, size.height - 8)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height + 20)
      ..lineTo(0, size.height + 20)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Transição customizada (fade + leve deslize) para navegação entre telas.
class FadeSlideRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeSlideRoute({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 320),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.04),
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
        );
}
