import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stock_careers/blocs/blog/blog_bloc.dart';
import 'package:stock_careers/blocs/blog/blog_event.dart';
import 'package:stock_careers/blocs/blog/blog_state.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/data/services/blog_service.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  late BlogBloc _blogBloc;

  @override
  void initState() {
    super.initState();
    _blogBloc = BlogBloc(BlogService())..add(FetchBlogsEvent());
  }

  @override
  void dispose() {
    _blogBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _blogBloc,
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
                  "Blog",
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
        body: BlocBuilder<BlogBloc, BlogState>(
          builder: (context, state) {
            if (state is BlogLoading) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 5,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                },
              );
            } else if (state is BlogLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
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
                              child: Image.network(blog.blogImage,
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
                                    blog.blogName,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    blog.blogDesc,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white70),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/blogDetail',
                                        arguments: blog.id,
                                      );
                                    },
                                    child: const Text("Read More", 
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: AppColors.lightPrimary,
                                      fontSize: 14,
                                    
                                    ),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is BlogError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
