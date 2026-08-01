import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../services/bible_service.dart';
import 'bible_chapter_list_screen.dart';

class BibleBooksScreen extends StatefulWidget {
  const BibleBooksScreen({super.key});

  @override
  State<BibleBooksScreen> createState() =>
      _BibleBooksScreenState();
}

class _BibleBooksScreenState extends State<BibleBooksScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 900,
      ),
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

    final books = BibleService.books;


    return Scaffold(

      backgroundColor: AppColors.paper,


      appBar: AppBar(

        backgroundColor: AppColors.navy,

        foregroundColor: Colors.white,

        title: const Text(
          'Bíblia Sagrada',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

      ),


      body: FadeTransition(

        opacity: _animation,

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [


            Container(

              width: double.infinity,

              padding: const EdgeInsets.fromLTRB(
                22,
                24,
                22,
                28,
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

                  bottomLeft:
                      Radius.circular(30),

                  bottomRight:
                      Radius.circular(30),

                ),

              ),


              child: const Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,


                children: [


                  Text(

                    'Leia a Palavra de Deus',

                    style: TextStyle(

                      color: Colors.white,

                      fontSize: 24,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),


                  SizedBox(height: 8),


                  Text(

                    'Escolha um livro para começar sua leitura.',

                    style: TextStyle(

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
                    books.length,


                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 2,

                  crossAxisSpacing: 16,

                  mainAxisSpacing: 16,

                  childAspectRatio: 1.45,

                ),


                itemBuilder: (context,index){


                  final book = books[index];


                  return InkWell(

                    borderRadius:
                        BorderRadius.circular(22),


                    onTap: (){

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              BibleChapterListScreen(
                                book: book,
                              ),

                        ),

                      );

                    },


                    child: Container(

                      padding:
                          const EdgeInsets.all(18),


                      decoration: BoxDecoration(

                        color: Colors.white,


                        borderRadius:
                            BorderRadius.circular(22),


                        boxShadow: [

                          BoxShadow(

                            color: AppColors.navy
                                .withOpacity(0.08),

                            blurRadius: 15,

                            offset:
                                const Offset(0,8),

                          ),

                        ],

                      ),


                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,


                        mainAxisAlignment:
                            MainAxisAlignment.center,


                        children: [


                          Container(

                            width: 42,

                            height: 42,


                            decoration:
                                BoxDecoration(

                              color:
                                  AppColors.bronzeSoft,

                              shape:
                                  BoxShape.circle,

                            ),


                            child: const Icon(

                              Icons.menu_book_rounded,

                              color:
                                  AppColors.bronze,

                            ),

                          ),


                          const SizedBox(height: 12),


                          Text(

                            book.name,

                            style:
                                const TextStyle(

                              color:
                                  AppColors.navy,

                              fontSize: 16,

                              fontWeight:
                                  FontWeight.bold,

                            ),

                          ),


                        ],

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
  
