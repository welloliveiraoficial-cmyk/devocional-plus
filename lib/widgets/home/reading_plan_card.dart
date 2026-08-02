import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ReadingPlanCard extends StatefulWidget {
  const ReadingPlanCard({super.key});

  @override
  State<ReadingPlanCard> createState() => _ReadingPlanCardState();
}

class _ReadingPlanCardState extends State<ReadingPlanCard> with SingleTickerProviderStateMixin {
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
        margin: const EdgeInsets.fromLTRB(22, 24, 22, 0),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(color: AppColors.primary.withOpacity(0.07), blurRadius: 18, offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(color: AppColors.goldSoft, shape: BoxShape.circle),
                      child: const Icon(Icons.auto_stories_rounded, color: AppColors.gold),
                    ),
                    const SizedBox(width: 12),
                    const Text('Plano de Leitura', style: TextStyle(color: AppColors.ink, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Text('42%', style: TextStyle(color: AppColors.gold, fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            const Text('30 dias mais perto de Deus', style: TextStyle(color: AppColors.ink, fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 0.42,
                minHeight: 10,
                backgroundColor: AppColors.emberSoft,
                valueColor: const AlwaysStoppedAnimation(AppColors.gold),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.local_fire_department_rounded, color: AppColors.gold, size: 18),
                const SizedBox(width: 6),
                Text('6 dias seguidos', style: TextStyle(color: AppColors.inkLight, fontSize: 12, fontWeight: FontWeight.w500)),
                const Spacer(),
                Text('Dia 13 de 30', style: TextStyle(color: AppColors.inkLight, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
