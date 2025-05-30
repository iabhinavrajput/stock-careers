import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stock_careers/blocs/ebook/ebook_bloc.dart';
import 'package:stock_careers/blocs/ebook/ebook_event.dart';
import 'package:stock_careers/blocs/ebook/ebook_state.dart';
import '../../../data/services/ebook_service.dart';
import '../../../utils/constants/colors.dart';
import 'package:stock_careers/presentation/widgets/bottom_nav_bar.dart'; // ✅ Import BottomNavBar

import '../../utils/constants/dimensions.dart';
import '../widgets/app_shimmer.dart';

class EbookScreen extends StatefulWidget {
  const EbookScreen({super.key});

  @override
  State<EbookScreen> createState() => _EbookScreenState();
}

class _EbookScreenState extends State<EbookScreen> {
  late EbookBloc ebookBloc;

  @override
  void initState() {
    super.initState();
    ebookBloc = EbookBloc(EbookService())..add(LoadEbooks());
  }

  @override
  void dispose() {
    ebookBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ebookBloc,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 85,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.background
              : Colors.white,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "E-Books",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Image.asset(
                  'assets/images/avatar.png',
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.background
            : Colors.white,
        body: BlocBuilder<EbookBloc, EbookState>(
          builder: (context, state) {
            if (state is EbookLoading) {
              return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.shimmerCount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: AppShimmer(
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 120,
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  // color: Colors.grey.shade700,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 16,
                                        width: 180,
                                        color: Colors.grey.shade700,
                                      ),
                                      Container(
                                        height: 14,
                                        width: 120,
                                        color: Colors.grey.shade700,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 14,
                                            width: 60,
                                            color: Colors.grey.shade700,
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            height: 14,
                                            width: 50,
                                            color: Colors.grey.shade700,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 12,
                                        width: 200,
                                        color: Colors.grey.shade700,
                                      ),
                                      Container(
                                        height: 12,
                                        width: 140,
                                        color: Colors.grey.shade700,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else if (state is EbookLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.ebooks.length,
                itemBuilder: (context, index) {
                  final ebook = state.ebooks[index];
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.cardBackground
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              width: Dimensions.screenWidth * 0.33,
                            
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: AspectRatio(
                                  aspectRatio:
                                      16/10, // ← keeps a horizontal feel
                                  child:Image.network(ebook.image,
                                  width: 80, height: 100, fit: BoxFit.cover),))
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      ebook.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      ebook.desc,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                     GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          '/ebookDetail',
                                          arguments: ebook.id,
                                        );
                                    },
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        'Read more ›',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: AppColors.lightPrimary),
                                      ),
                                    ),
                                  ),
                                    // TextButton(
                                    //   onPressed: () {
                                    //     Navigator.pushNamed(
                                    //       context,
                                    //       '/ebookDetail',
                                    //       arguments: ebook.id,
                                    //     );
                                    //   },
                                    //   child:Align(
                                    //   alignment: Alignment.bottomRight,
                                    //   child: const Text(
                                    //     "Read More",
                                    //     textAlign: TextAlign.right,
                                    //     style: TextStyle(
                                    //       color: AppColors.lightPrimary,
                                    //       fontSize: 14,
                                    //     ),
                                    //   ),
                                    //   )
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              );
            } else if (state is EbookError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
        // bottomNavigationBar: BottomNavBar(
        //   currentIndex: 3, // Set the current index for the active tab
        //   onTabTapped: (index) {
        //     // Handle tab navigation logic here
        //     if (index == 0) {
        //       Navigator.pushNamed(context, '/home');
        //     } else if (index == 1) {
        //       Navigator.pushNamed(context, '/course');
        //     } else if (index == 2) {
        //       Navigator.pushNamed(context, '/blog');
        //     } else if (index == 4) {
        //       Navigator.pushNamed(context, '/profile');
        //     }
        //   },
        // ),
      ),
    );
  }
}
