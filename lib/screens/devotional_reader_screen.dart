import 'package:flutter/material.dart';
import '../models/devotional.dart';
import '../theme/app_theme.dart';

class DevotionalReaderScreen extends StatelessWidget {
  final Devotional devotional;

  const DevotionalReaderScreen({
    super.key,
    required this.devotional,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.navy,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  80,
                  24,
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
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.end,
                  children: [

                    Text(
                      devotional.theme.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.bronze,
                        fontSize: 11,
                        fontWeight:
                            FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      devotional.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          size: 14,
                          color: AppColors.bronzeSoft,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${devotional.readingMinutes} minutos de leitura',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),


          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.bronzeSoft,
                      borderRadius:
                          BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        const Text(
                          'VERSÍCULO DO DIA',
                          style: TextStyle(
                            color: AppColors.bronze,
                            fontSize: 11,
                            fontWeight:
                                FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          '"${devotional.verseText}"',
                          style: const TextStyle(
                            color:
                                Color(0xFF4A3A28),
                            fontSize: 16,
                            fontStyle:
                                FontStyle.italic,
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          devotional.verseRef,
                          style: const TextStyle(
                            color:
                                Color(0xFF4A3A28),
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),


                  _ContentCard(
                    title: 'Reflexão',
                    icon: Icons.lightbulb_outline,
                    text: devotional.reflection,
                  ),


                  _ContentCard(
                    title: 'Aplicação Prática',
                    icon: Icons.check_circle_outline,
                    text: devotional.application,
                  ),


                  _ContentCard(
                    title: 'Oração',
                    icon: Icons.volunteer_activism_outlined,
                    text: devotional.prayer,
                  ),


                  const SizedBox(height: 20),


                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [

                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                        ),
                        label:
                            const Text('Favoritar'),
                      ),

                      const SizedBox(width: 14),

                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.share_outlined,
                        ),
                        label:
                            const Text('Compartilhar'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _ContentCard extends StatelessWidget {

  final String title;
  final IconData icon;
  final String text;


  const _ContentCard({
    required this.title,
    required this.icon,
    required this.text,
  });


  @override
  Widget build(BuildContext context) {

    return Container(
      margin:
          const EdgeInsets.only(top: 18),

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color:
                AppColors.navy.withOpacity(0.06),
            blurRadius: 16,
            offset:
                const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Icon(
                icon,
                color: AppColors.bronze,
                size: 20,
              ),

              const SizedBox(width: 8),

              Text(
                title,
                style: const TextStyle(
                  color: AppColors.navy,
                  fontSize: 15,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),


          const SizedBox(height: 14),


          Text(
            text,
            style: const TextStyle(
              color:
                  Color(0xFF3A4A5F),
              fontSize: 15,
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}
