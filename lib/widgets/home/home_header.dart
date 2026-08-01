import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class HomeHeader extends StatefulWidget {
  final String saudacao;

  const HomeHeader({
    super.key,
    required this.saudacao,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader>
    with TickerProviderStateMixin {
  late AnimationController _entryController;
  late Animation<double> _entryAnimation;

  late AnimationController _symbolController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _floatAnimation;

  bool get isDay {
    final hour = DateTime.now().hour;
    return hour >= 6 && hour < 18;
  }

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _entryAnimation = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOut,
    );

    _entryController.forward();

    _symbolController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 6.28,
    ).animate(_symbolController);

    _floatAnimation = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(
      CurvedAnimation(
        parent: _symbolController,
        curve: Curves.easeInOut,
      ),
    );

    _symbolController.repeat();
  }

  @override
  void dispose() {
    _entryController.dispose();
    _symbolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _entryAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.15),
          end: Offset.zero,
        ).animate(_entryAnimation),
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            22,
            55,
            22,
            30,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.navy,
                AppColors.navy2,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                widget.saudacao,
                style: const TextStyle(
                  color: AppColors.bronzeSoft,
                  fontSize: 13,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Que a presença de Deus esteja com você hoje.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  height: 1.3,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: AppColors.bronze,
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [

                    AnimatedBuilder(
                      animation: _symbolController,
                      builder: (context, child) {

                        return Transform.translate(
                          offset: Offset(
                            0,
                            isDay
                                ? 0
                                : _floatAnimation.value,
                          ),

                          child: Transform.rotate(
                            angle: isDay
                                ? _rotationAnimation.value
                                : 0,

                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: AppColors.bronze
                                    .withOpacity(0.18),
                                shape: BoxShape.circle,
                              ),

                              child: Icon(
                                isDay
                                    ? Icons.wb_sunny_rounded
                                    : Icons.nightlight_round,
                                color: AppColors.bronze,
                                size: 26,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Text(
                        'Comece seu dia com fé, oração e uma palavra de esperança.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.4,
                        ),
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
