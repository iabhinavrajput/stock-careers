import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/blocs/blog/blog_detail_bloc.dart';
import 'package:stock_careers/blocs/blog/blog_detail_event.dart';
import 'package:stock_careers/blocs/blog/blog_detail_state.dart';
import 'package:stock_careers/data/services/blog_service.dart';

class BlogDetailScreen extends StatelessWidget {
  final String blogId;

  const BlogDetailScreen({super.key, required this.blogId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlogDetailBloc(BlogService())..add(FetchBlogDetailEvent(blogId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Blog Detail')),
        body: BlocBuilder<BlogDetailBloc, BlogDetailState>(
          builder: (context, state) {
            if (state is BlogDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BlogDetailLoaded) {
              final blog = state.blog;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(blog.blogImage),
                    const SizedBox(height: 16),
                    Text(blog.blogName, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text("By ${blog.blogAuthor} on ${blog.blogDate}"),
                    const Divider(height: 32),
                    Text(blog.blogDesc),
                    const SizedBox(height: 16),
                    Text(blog.longDesc.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ''),
                        style: TextStyle(fontSize: 16)), // Optional: Clean HTML
                  ],
                ),
              );
            } else if (state is BlogDetailError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
