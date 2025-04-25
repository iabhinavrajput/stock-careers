import 'package:flutter/material.dart';
import 'package:stock_careers/utils/constants/colors.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';

class StaticContentScreen extends StatelessWidget {
  final String title;
  final String content;

  const StaticContentScreen({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.background
            : Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.pagePadding),
        child: SingleChildScrollView(
          child: Text(
            content, 
            style:Theme.of(context).textTheme.titleMedium
          ),
        ),
      ),
    );
  }
}
