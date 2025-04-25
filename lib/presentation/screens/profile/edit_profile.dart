import 'package:flutter/material.dart';
import 'package:stock_careers/presentation/widgets/button/button.dart';
import 'package:stock_careers/presentation/widgets/field/email.dart';
import 'package:stock_careers/presentation/widgets/field/mobile.dart';
import 'package:stock_careers/presentation/widgets/input_field.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';

import '../../../utils/constants/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.background
          : Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.background
            : Colors.white,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Profile",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.pagePadding,
            ),
            Image.asset(
              'assets/images/avatar.png',
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: Dimensions.pagePadding,
            ),
            InputField(
                label: 'First Name',
                controller: TextEditingController(),
                hintText: 'hintText'),
            SizedBox(
              height: Dimensions.screenHeight * 0.01,
            ),
            InputField(
                label: 'Last name',
                controller: TextEditingController(),
                hintText: 'hintText'),
            SizedBox(
              height: Dimensions.screenHeight * 0.01,
            ),
            CustomEmailTextField(controller: TextEditingController()),
            SizedBox(
              height: Dimensions.screenHeight * 0.01,
            ),
            CustomMobileField(
              controller: TextEditingController(),
              onValidationChanged: (isValid) {
                // isMobileValid = isValid;
                // validateForm();
              },
            ),
              SizedBox(
              height: Dimensions.screenHeight * 0.05,
            ),
            CustomButton(text: "Save", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
