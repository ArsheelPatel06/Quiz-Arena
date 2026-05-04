import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:quiz_app_flutter/utlis/app_assets%20.dart';
import 'package:quiz_app_flutter/utlis/app_text.dart';
import 'package:quiz_app_flutter/widget/custom_text_form_field%20.dart';

import '../../../utlis/app_colors.dart';
import '../../../utlis/app_routes .dart';
import '../../../widget/custom_elevated_button .dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(
      text: 'ahmed@gmail.com');
  final TextEditingController passwordController = TextEditingController(
      text: '123456');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body:  Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: height * 0.05,),
            Image.asset(AppAssets.logo),
            SizedBox(height: height * 0.05,),
            Text('Welcome Back', style: AppTextStyle.bold32Black,),
            SizedBox(height: height * 0.01,),
            Text('Please enter your details to sign in to your account.', style: AppTextStyle.normal16Grey,),
            SizedBox(height: height * 0.04,),
            Text('Email', style: AppTextStyle.medium14Black,),
            SizedBox(height: height * 0.01,),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.greyColor,
                      size: 24,
                    ),
                    hintText: 'Email',
                    hintStyle: AppTextStyle.normal16Grey,
                    labelStyle: AppTextStyle.normal16Grey,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter email';
                      }
                      final bool emailValid =
                      RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextFormField(
                    prefixIcon: Icon(
                      Clarity.lock_solid,
                      color: AppColors.greyColor,
                      size: 24,
                    ),
                    hintText: 'Password',
                    hintStyle: AppTextStyle.normal16Grey, // ثابت Light Mode
                    controller: passwordController,
                    obscuringCharacter: '*',
                    obscureText: true,
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
                  SizedBox(height: height * 0.005),
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        /// reset screen
                      },
                      child: Text(
                        'Forgot Password?',
                        style: AppTextStyle.bold16Purple.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.purpleColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  CustomElevatedButton(
                    onPressed: () {
                      //nav to home screen
                      // return login(); // Logic remains as is
                    },
                    text: 'Login',
                  ),
                  SizedBox(height: height * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.registerScreen);
                        },
                        child: Text(
                          'Create Account',
                          style: AppTextStyle.bold16Purple.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.purpleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.015),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.outlineGrey,
                          indent: width * 0.04,
                          endIndent: width * 0.03,
                        ),
                      ),
                      Text(
                        'Or',
                        style: AppTextStyle.normal16Grey,
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.outlineGrey,
                          indent: width * 0.04,
                          endIndent: width * 0.03,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  CustomElevatedButton(
                    onPressed: () {
                      // login with google
                      // signInWithGoogle();
                      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.mainWrapperScreen,(_) => false,);
                    },
                    hasIcon: true,
                    borderSideColor: AppColors.purpleColor,
                    backgroundColor: AppColors.transparentColor,
                    customInButton: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Brand(Brands.google, size: 26),
                        SizedBox(width: width * 0.02),
                        Text(
                          'Login with Google',
                          style: AppTextStyle.bold16Purple,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}