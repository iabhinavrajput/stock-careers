import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stock_careers/blocs/ebook/ebook_bloc.dart';
import 'package:stock_careers/blocs/ebook/ebook_event.dart';
import 'package:stock_careers/blocs/ebook/ebook_state.dart';
import '../../../data/services/ebook_service.dart';
import '../../../utils/constants/colors.dart';
import 'package:stock_careers/presentation/widgets/bottom_nav_bar.dart'; // ✅ Import BottomNavBar


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
          backgroundColor: AppColors.background,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "E-Books",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
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
        backgroundColor: AppColors.background,
        body: BlocBuilder<EbookBloc, EbookState>(
          builder: (context, state) {
            if (state is EbookLoading) {
              return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.shimmerCount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade800,
                        highlightColor: Colors.grey.shade700,
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 120,
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade700,
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
                        height: 150,
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.cardBackgroundLight,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.network(ebook.image,
                                  width: 80, height: 100, fit: BoxFit.cover),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      ebook.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      ebook.desc,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white70),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/ebookDetail',
                                          arguments: ebook.id,
                                        );
                                      },
                                      child: const Text(
                                        "Read More",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: AppColors.lightPrimary,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
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
        bottomNavigationBar: BottomNavBar(
          currentIndex: 3, // Set the current index for the active tab
          onTabTapped: (index) {
            // Handle tab navigation logic here
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/course');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/blog');
            } else if (index == 4) {
              Navigator.pushNamed(context, '/profile');
            }
          },
        ),
      ),
    );
  }
}
