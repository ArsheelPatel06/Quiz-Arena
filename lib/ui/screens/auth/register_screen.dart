import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:quiz_app_flutter/utlis/app_assets%20.dart';

import '../../../utlis/app_colors.dart';
import '../../../utlis/app_text.dart';
import '../../../widget/custom_elevated_button .dart';
import '../../../widget/custom_text_form_field%20.dart'; // تأكد من المسار الصحيح

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController(
    text: 'ahmed',
  );
  final TextEditingController emailController = TextEditingController(
    text: 'ahmed@gmail.com',
  );
  final TextEditingController passwordController = TextEditingController(
    text: '123456',
  );
  final formKey = GlobalKey<FormState>();
  final TextEditingController rePasswordController = TextEditingController(
    text: '123456',
  );

  bool showPassword = true;
  bool showConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.purpleColor),
        backgroundColor: AppColors.transparentColor,
        title: Text(
          'Register',
          style: AppTextStyle.medium28Black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image remains as per your assets
              SizedBox(height: height * 0.05,),
              Image.asset(AppAssets.logo),
              SizedBox(height: height * 0.05,),// تأكد من Assets
              SizedBox(height: height * 0.02),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(labelStyle: AppTextStyle.normal16Black,
                      controller: nameController,
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.greyColor,
                        size: 24,
                      ),
                      hintText: 'Name',
                      hintStyle: AppTextStyle.normal16Grey,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextFormField(
                      controller: emailController,

                      prefixIcon: Icon(
                        Icons.email,
                        color: AppColors.greyColor,
                        size: 24,
                      ),
                      hintText: 'Email',
                      hintStyle: AppTextStyle.normal16Grey,
                      keyboardType: TextInputType.emailAddress,
                      labelStyle: AppTextStyle.medium14Black,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter email';
                        }
                        final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ).hasMatch(text);
                        if (!emailValid) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextFormField(labelStyle: AppTextStyle.normal16Black,
                      prefixIcon: Icon(
                        Clarity.lock_solid,
                        color: AppColors.greyColor,
                        size: 24,
                      ),
                      hintText: 'Password',
                      hintStyle: AppTextStyle.normal16Grey,
                      obscureText: showPassword ? true : false,
                      obscuringCharacter: '*',
                      suffixIcon: IconButton(
                        icon: showPassword
                            ? Icon(Clarity.eye_hide_solid)
                            : Icon(Clarity.eye_show_solid),
                        onPressed: () {
                          showPassword = !showPassword;
                          setState(() {});
                        },
                        color: AppColors.greyColor,
                      ),
                      controller: passwordController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter password';
                        }
                        if (text.length < 6) {
                          return 'Password too short';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomTextFormField(labelStyle: AppTextStyle.normal16Black,
                      controller: rePasswordController,
                      prefixIcon: Icon(
                        Clarity.lock_solid,
                        color: AppColors.greyColor,
                        size: 24,
                      ),
                      hintText: 'Re-Password',
                      hintStyle: AppTextStyle.normal16Grey,
                      obscureText: showConfirmPassword ? true : false,
                      obscuringCharacter: '*',
                      suffixIcon: IconButton(
                        icon: showConfirmPassword ? Icon(
                          Clarity.eye_hide_solid,) : Icon(
                          Clarity.eye_show_solid,),
                        onPressed: () {
                          showConfirmPassword = !showConfirmPassword;
                          setState(() {});
                        },
                        color: AppColors.greyColor,
                      ),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please re-enter password';
                        }
                        if (text != passwordController.text) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    CustomElevatedButton(
                      onPressed: () {
                        createAccount();
                      },
                      text: 'Create Account',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Logic remains untouched as per your request
  void createAccount() async {
    // ... logic ...
  }
}