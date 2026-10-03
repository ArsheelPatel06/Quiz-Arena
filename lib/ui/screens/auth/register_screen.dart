import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quiz_app_flutter/utlis/app_assets%20.dart';

import '../../../core/services/auth_service.dart';
import '../../../firebase_utils.dart';
import '../../../models/user_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../utlis/app_colors.dart';
import '../../../utlis/app_routes .dart';
import '../../../utlis/app_text.dart';
import '../../../utlis/dialog_utlis.dart';
import '../../../widget/custom_elevated_button .dart';
import '../../../widget/custom_text_form_field%20.dart'; // تأكد من المسار الصحيح

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService authService = AuthService();
  final TextEditingController nameController = TextEditingController(
    text: 'arsheel',
  );
  final TextEditingController emailController = TextEditingController(
    text: 'arsheel@gmail.com',
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
                        Icons.lock,
                        color: AppColors.greyColor,
                        size: 24,
                      ),
                      hintText: 'Password',
                      hintStyle: AppTextStyle.normal16Grey,
                      obscureText: showPassword ? true : false,
                      obscuringCharacter: '*',
                      suffixIcon: IconButton(
                        icon: showPassword
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
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
                        Icons.lock,
                        color: AppColors.greyColor,
                        size: 24,
                      ),
                      hintText: 'Re-Password',
                      hintStyle: AppTextStyle.normal16Grey,
                      obscureText: showConfirmPassword ? true : false,
                      obscuringCharacter: '*',
                      suffixIcon: IconButton(
                        icon: showConfirmPassword ? Icon(
                          Icons.visibility_off,) : Icon(
                          Icons.visibility,),
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
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      // ✅ BUG FIX #2: Show loading dialog (was missing before)
      DialogUtlis.loadingDialog(context);

      try {
        // Step 1: Create user in Firebase Auth
        final credential = await authService.register(
          email: emailController.text,
          password: passwordController.text,
        );

        // Step 2: Build user model with the Firebase uid
        MyUsers myUser = MyUsers(
          id: credential.user?.uid ?? '',
          name: nameController.text.trim(),
          email: emailController.text.trim(),
        );

        // Step 3: Save user data to Firestore
        await FireBaseUtils.addUserToFireStore(myUser);

        // ✅ BUG FIX #4: Check mounted BEFORE using context
        if (!mounted) return;

        // Step 4: Save user in Provider so the rest of the app can access it
        Provider.of<MyUsersProvider>(context, listen: false).updateUsers(myUser);

        // ✅ BUG FIX #2: Hide loading dialog
        DialogUtlis.hideDialog(context);

        // ✅ BUG FIX #1: Navigate to main screen after register
        DialogUtlis.showDialogMessage(
          context: context,
          title: 'Success 🎉',
          middleText: 'Account created successfully!',
          buttonText: 'Let\'s Go',
          onButtonPressed: () {
            // Go to main screen and remove all previous routes
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.mainWrapperScreen,
                  (_) => false,
            );
          },
        );

      } on FirebaseAuthException catch (error) {
        // ✅ Always hide loading on error
        if (!mounted) return;
        DialogUtlis.hideDialog(context);

        String message = 'Something went wrong';

        if (error.code == 'weak-password') {
          message = 'The password provided is too weak';
        }
        if (error.code == 'email-already-in-use') {
          message = 'An account with this email already exists';
        }

        DialogUtlis.showDialogMessage(
          context: context,
          title: 'Error',
          middleText: message,
          buttonText: 'OK',
        );

      } catch (error) {
        print('🔴 Firebase Error Code: ${error.toString()}');
        // Catch any unexpected errors (e.g. Firestore network issues)
        if (!mounted) return;
        DialogUtlis.hideDialog(context);

        DialogUtlis.showDialogMessage(
          context: context,
          title: 'Error',
          middleText: error.toString(),
          buttonText: 'OK',
        );
      }
    }
  }}