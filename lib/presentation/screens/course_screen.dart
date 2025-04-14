import 'package:flutter/material.dart';
import 'package:stock_careers/utils/constants/colors.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        toolbarHeight: 85,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Courses",
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
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 20,), 
          child: Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.cardBackgroundLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                        'assets/images/avatar.png',
                        height: 100,
                        width: 100,
                      ),
                      ),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Course Title",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Course Description",
                            style: TextStyle(
                              color: AppColors.hint,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            
                            children: [
                                    Text(
                                  "Price: \$99",
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  "4 weeks",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                          
                        ],
                      ),
                      
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
              )
            ],
          ),
        ),
          
        ),
     
    );
  }
}