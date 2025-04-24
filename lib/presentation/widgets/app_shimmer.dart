import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Light‑weight wrapper that gives you a ready‑to‑use shimmer.
/// Just pass the child you want to “shine” and (optionally)
/// override the base / highlight colors.
class AppShimmer extends StatelessWidget {
  const AppShimmer({
    super.key,
    required this.child,
    this.baseLight  = const Color(0xFFF5F5F5),
    this.baseDark   = const Color(0xFF424242),
    this.highlightLight = const Color(0xFFE0E0E0),
    this.highlightDark  = const Color(0xFF616161),
  });

  final Widget child;

  // You can still override colors if a particular screen
  // needs something special.
  final Color baseLight;
  final Color baseDark;
  final Color highlightLight;
  final Color highlightDark;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor:     isDark ? baseDark      : baseLight,
      highlightColor: isDark ? highlightDark : highlightLight,
      child: child,
    );
  }
}
