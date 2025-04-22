import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/blocs/blog/blog_bloc.dart';
import 'package:stock_careers/blocs/blog/blog_event.dart';
import 'package:stock_careers/blocs/blog/blog_state.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/data/services/blog_service.dart';  // Correct path and case


class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogBloc(BlogService())..add(FetchBlogsEvent()),
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
        backgroundColor: AppColors.white,
        body: BlocBuilder<BlogBloc, BlogState>(
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BlogLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          blog.blogImage,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        blog.blogName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(blog.blogDesc),
                      onTap: () {
                        // Navigate to detail screen
                        Navigator.pushNamed(
                          context,
                          '/blogDetail',
                          arguments: blog.id,
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is BlogError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
