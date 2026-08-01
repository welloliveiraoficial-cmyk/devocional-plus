import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../services/bible_service.dart';
import 'bible_reader_screen.dart';

class BibleChapterListScreen extends StatefulWidget {
  final BibleBook book;

  const BibleChapterListScreen({
    super.key,
    required this.book,
  });

  @override
  State<BibleChapterListScreen> createState() =>
      _BibleChapterListScreenState();
}

class _BibleChapterListScreenState
    extends State<BibleChapterListScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.paper,


      appBar: AppBar(

        backgroundColor: AppColors.navy,

        foregroundColor: Colors.white,

        title: Text(
          widget.book.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

      ),


      body: FadeTransition(

        opacity: _animation,

        child: Column(

          children: [


            Container(

              width: double.infinity,

              padding: const EdgeInsets.fromLTRB(
                22,
                24,
                22,
                26,
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


                borderRadius:
                    BorderRadius.only(

                  bottomLeft:
                      Radius.circular(30),

                  bottomRight:
                      Radius.circular(30),

                ),

              ),


              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,


                children: [


                  Text(

                    'Capítulos de ${widget.book.name}',

                    style: const TextStyle(

                      color: Colors.white,

                      fontSize: 22,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),


                  const SizedBox(height: 8),


                  Text(

                    '${widget.book.chapters} capítulos disponíveis',

                    style: const TextStyle(

                      color: Colors.white70,

                      fontSize: 14,

                    ),

                  ),

                ],

              ),

            ),


            const SizedBox(height: 20),


            Expanded(

              child: GridView.builder(

                padding:
                    const EdgeInsets.symmetric(
                      horizontal: 22,
                    ),


                itemCount:
                    widget.book.chapters,


                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 4,

                  crossAxisSpacing: 14,

                  mainAxisSpacing: 14,

                  childAspectRatio: 1,

                ),


                itemBuilder:
                    (context, index) {


                  final chapter = index + 1;


                  return InkWell(

                    borderRadius:
                        BorderRadius.circular(18),


                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              BibleReaderScreen(

                            book: widget.book,

                            chapter: chapter,

                          ),

                        ),

                      );

                    },


                    child: Container(

                      decoration:
                          BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(18),

                        boxShadow: [

                          BoxShadow(

                            color: AppColors.navy
                                .withOpacity(0.08),

                            blurRadius: 12,

                            offset:
                                const Offset(0, 6),

                          ),

                        ],

                      ),


                      child: Center(

                        child: Column(

                          mainAxisSize:
                              MainAxisSize.min,


                          children: [


                            const Icon(

                              Icons.auto_stories_rounded,

                              color:
                                  AppColors.bronze,

                            ),


                            const SizedBox(height: 8),


                            Text(

                              '$chapter',

                              style:
                                  const TextStyle(

                                color:
                                    AppColors.navy,

                                fontSize: 17,

                                fontWeight:
                                    FontWeight.bold,

                              ),

                            ),

                          ],

                        ),

                      ),

                    ),

                  );

                },

              ),

            ),

          ],

        ),

      ),

    );

  }

}
