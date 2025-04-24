import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_careers/blocs/blog/blog_bloc.dart';
import 'package:stock_careers/blocs/blog/blog_event.dart';
import 'package:stock_careers/blocs/blog/blog_state.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';
import '../../data/services/blog_service.dart';
import 'app_shimmer.dart';

class RecentBlogs extends StatelessWidget {
  const RecentBlogs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlogBloc(BlogService()) // ← supply BlogService
        ..add(FetchBlogsEvent()),
      child: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return _buildShimmerList(context);
          }
          if (state is BlogLoaded) {
            final blogs = state.blogs.take(3).toList(); // ← only 3
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              itemCount: blogs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (ctx, i) => _BlogTile(blog: blogs[i]),
            );
          }
          if (state is BlogError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: Text(state.message,
                  style: Theme.of(context).textTheme.titleSmall),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  /// --- Skeleton while loading ------------------------------------------------
  Widget _buildShimmerList(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, __) => AppShimmer(
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade800
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

/// --- Single blog card --------------------------------------------------------
class _BlogTile extends StatelessWidget {
  const _BlogTile({required this.blog});
  final dynamic blog; // replace with your Blog model

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/blogDetail',
        arguments: blog.id,
      ),
      child: Container(
        width: Dimensions.screenWidth,
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
              width: 90,
              height: 90,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(blog.blogImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blog.blogName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.005),
                      Text(
                        blog.blogDesc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),

                      /// push everything that follows to the bottom
                      const Spacer(), // ← adds flexible empty space

                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Read more ›',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.lightPrimary),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
