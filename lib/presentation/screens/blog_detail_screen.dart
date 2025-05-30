import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stock_careers/blocs/blog/blog_detail_bloc.dart';
import 'package:stock_careers/blocs/blog/blog_detail_event.dart';
import 'package:stock_careers/blocs/blog/blog_detail_state.dart';
import 'package:stock_careers/data/services/blog_service.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as html_parser;

import '../../utils/constants/share_helper.dart';
import '../widgets/app_shimmer.dart';

class BlogDetailScreen extends StatefulWidget {
  final String blogId;

  const BlogDetailScreen({super.key, required this.blogId});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  late BlogDetailBloc _blogDetailBloc;

  @override
  void initState() {
    super.initState();
    _blogDetailBloc = BlogDetailBloc(BlogService());
    _blogDetailBloc.add(FetchBlogDetailEvent(widget.blogId));
  }

  @override
  void dispose() {
    _blogDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String slugify(String title) {
  return title
      .toLowerCase()
      // .replaceAll(RegExp(r'[^\w\s-]'), '') // remove special chars
      .replaceAll(RegExp(r'\s+'), '-')     // spaces to dashes
      .replaceAll(RegExp(r'-+'), '-');     // collapse multiple dashes
}

    final screenHeight = MediaQuery.of(context).size.height;
    final shimmerHeight = screenHeight *
        0.3; // Dynamically set shimmer height based on screen height
    final contentHeight = screenHeight * 0.7; // Content area after shimmer

    return BlocProvider.value(
      value: _blogDetailBloc,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocBuilder<BlogDetailBloc, BlogDetailState>(
          builder: (context, state) {
            print("Current state: $state"); // Debugging print
            if (state is BlogDetailLoading) {
              // Show shimmer or loader
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: shimmerHeight,
                    child: Container(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey.shade800
                          : Colors.grey.shade100,
                    ),
                  ),
                  Positioned(
                    top: shimmerHeight,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.cardBackground
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: AppShimmer(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: shimmerHeight * 0.1,
                                  width: 200,
                                  color: Colors.grey),
                              const SizedBox(height: 10),
                              Container(
                                  height: shimmerHeight * 0.1,
                                  width: 100,
                                  color: Colors.grey),
                              const SizedBox(height: 30),
                              Container(
                                  height: shimmerHeight * 0.2,
                                  width: 150,
                                  color: Colors.grey),
                              const SizedBox(height: 10),
                              Container(
                                  height: shimmerHeight * 0.2,
                                  width: double.infinity,
                                  color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is BlogDetailLoaded) {
              final blog = state.blog;

              // Parse the HTML description
              final document = html_parser.parse(blog.blogDesc);
              final parsedDescription = document.body?.text ?? '';

              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom:
                        screenHeight * 0.7, // Dynamically adjust shimmer area
                    child: blog.blogImage.isNotEmpty
                        ? Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(blog.blogImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            color:
                                AppColors.grey, // Show grey color if no image
                          ),
                  ),
                  Positioned(
                    top: screenHeight * 0.27,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.cardBackground
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      blog.blogName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                      // maxLines: 2,
                                      // overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    icon: const Icon(Icons.share,
                                        color: AppColors.white),
                                    onPressed: () {
                                      final blogSlug = slugify(blog.blogName);
                                      final url =
                                          'https://stockcareers.com/blog-details/$blogSlug';
                                      Share.share('Check out this blog: $url');
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Author: ${blog.blogAuthor}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Render the parsed HTML description with custom styles
                              Html(
                                data: blog.blogDesc, // Use the original HTML
                                style: {
                                  // Apply styles to HTML tags
                                  'body': Style(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey.shade300
                                        : Colors.grey
                                            .shade700, // Change body text color
                                  ),
                                  'p': Style(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.grey, // Paragraph text color
                                    fontSize: FontSize(16),
                                  ),
                                  'h1': Style(
                                    color: AppColors.primary, // Header 1 color
                                    fontSize: FontSize(24),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  'h2': Style(
                                    color: AppColors.primary, // Header 2 color
                                    fontSize: FontSize(20),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  'a': Style(
                                    color: AppColors.primary, // Link color
                                    fontSize: FontSize(16),
                                    textDecoration: TextDecoration.underline,
                                  ),
                                  'img': Style(
                                    width: Width(double
                                        .infinity), // Ensure image stretches across
                                    height: Height(
                                        250), // Set a fixed height for images
                                  ),
                                },
                              ),
                              Html(
                                data: blog.longDesc, // Use the original HTML
                                style: {
                                  // Apply styles to HTML tags
                                  'body': Style(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey.shade300
                                        : Colors.grey.shade700,
                                    // fontSize: FontSize(16),
                                    // Change body text color
                                  ),
                                  'p': Style(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.grey.shade300
                                        : Colors.grey, // Paragraph text color
                                    // fontSize: FontSize(16),
                                  ),
                                  'h1': Style(
                                    color: AppColors.primary, // Header 1 color
                                    fontSize: FontSize(24),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  'h2': Style(
                                    color: AppColors.primary, // Header 2 color
                                    fontSize: FontSize(20),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  'a': Style(
                                    color: AppColors.primary, // Link color
                                    fontSize: FontSize(16),
                                    textDecoration: TextDecoration.underline,
                                  ),
                                  'img': Style(
                                    width: Width(double
                                        .infinity), // Ensure image stretches across
                                    height: Height(
                                        250), // Set a fixed height for images
                                  ),
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.4),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is BlogDetailError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
