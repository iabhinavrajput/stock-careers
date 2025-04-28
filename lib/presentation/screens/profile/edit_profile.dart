import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:stock_careers/presentation/widgets/button/button.dart';
import 'package:stock_careers/presentation/widgets/field/email.dart';
import 'package:stock_careers/presentation/widgets/field/mobile.dart';
import 'package:stock_careers/presentation/widgets/input_field.dart';
import 'package:stock_careers/utils/constants/dimensions.dart';

import '../../../data/models/user_model.dart';
import '../../../utils/constants/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? token;
  UserModel? user;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  Future<void> _getToken() async {
    final storage = const FlutterSecureStorage();
    final storedToken = await storage.read(key: 'access_token');
    if (storedToken != null) {
      setState(() {
        token = storedToken;
        final decodedToken = Jwt.parseJwt(token!);

        // Debugging: print the decoded token to check its structure
        print('Decoded Token: $decodedToken');

        // Map the decoded token to the UserModel
        user = UserModel.fromMap(decodedToken);

        // Debugging: print the user data to ensure it's being populated correctly
        print(
            'User data: ${user?.firstname}, ${user?.lastname}, ${user?.email}, ${user?.phone}');

        // Set the controllers' text with the user data
        firstNameController.text = user?.firstname ?? '';
        lastNameController.text = user?.lastname ?? '';
        emailController.text = user?.email ?? '';
        mobileController.text = user?.phone ?? '';
      });
    }
  }

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
                controller: firstNameController,
                hintText: user?.firstname ?? 'Enter your first name'),
            SizedBox(
              height: Dimensions.screenHeight * 0.01,
            ),
            InputField(
                label: 'Last Name',
                controller: lastNameController,
                hintText: user?.lastname ?? 'Enter your first name'),
            SizedBox(
              height: Dimensions.screenHeight * 0.01,
            ),
            CustomEmailTextField(controller: emailController),
            SizedBox(
              height: Dimensions.screenHeight * 0.01,
            ),
            CustomMobileField(
              controller: mobileController,
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
