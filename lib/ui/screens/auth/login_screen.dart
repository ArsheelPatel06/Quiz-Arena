// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// 
// import 'package:provider/provider.dart';
// import 'package:quiz_app_flutter/utlis/app_assets%20.dart';
// import 'package:quiz_app_flutter/utlis/app_text.dart';
// import 'package:quiz_app_flutter/widget/custom_text_form_field%20.dart';
//
// import '../../../core/services/auth_service.dart';
// import '../../../firebase_utils.dart';
// import '../../../models/user_model.dart';
// import '../../../providers/auth_provider.dart';
// import '../../../utlis/app_colors.dart';
// import '../../../utlis/app_routes .dart';
// import '../../../utlis/dialog_utlis.dart';
// import '../../../widget/custom_elevated_button .dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final AuthService authService = AuthService();
//   final formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController(
//       text: 'arsheel@gmail.com');
//   final TextEditingController passwordController = TextEditingController(
//       text: '123456');
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: AppColors.bgLight,
//       body:  Padding(
//         padding:  EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.02),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: height * 0.05,),
//             Image.asset(AppAssets.logo),
//             SizedBox(height: height * 0.05,),
//             Text('Welcome Back', style: AppTextStyle.bold32Black,),
//             SizedBox(height: height * 0.01,),
//             Text('Please enter your details to sign in to your account.', style: AppTextStyle.normal16Grey,),
//             SizedBox(height: height * 0.04,),
//             Text('Email', style: AppTextStyle.medium14Black,),
//             SizedBox(height: height * 0.01,),
//             Form(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   CustomTextFormField(
//                     prefixIcon: Icon(
//                       Icons.email,
//                       color: AppColors.greyColor,
//                       size: 24,
//                     ),
//                     hintText: 'Email',
//                     hintStyle: AppTextStyle.normal16Grey,
//                     labelStyle: AppTextStyle.normal16Grey,
//                     keyboardType: TextInputType.emailAddress,
//                     controller: emailController,
//                     validator: (text) {
//                       if (text == null || text.trim().isEmpty) {
//                         return 'Please enter email';
//                       }
//                       final bool emailValid =
//                       RegExp(
//                           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                           .hasMatch(text);
//                       if (!emailValid) {
//                         return 'Please enter valid email';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: height * 0.02),
//                   CustomTextFormField(
//                     prefixIcon: Icon(
//                       Icons.lock,
//                       color: AppColors.greyColor,
//                       size: 24,
//                     ),
//                     hintText: 'Password',
//                     hintStyle: AppTextStyle.normal16Grey, // ثابت Light Mode
//                     controller: passwordController,
//                     obscuringCharacter: '*',
//                     obscureText: true,
//                     validator: (text) {
//                       if (text == null || text.trim().isEmpty) {
//                         return 'Please enter password';
//                       }
//                       if (text.length < 6) {
//                         return 'Password too short';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: height * 0.005),
//                   Container(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {
//                         /// reset screen
//                       },
//                       child: Text(
//                         'Forgot Password?',
//                         style: AppTextStyle.bold16Purple.copyWith(
//                           decoration: TextDecoration.underline,
//                           decorationColor: AppColors.purpleColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: height * 0.02),
//                   CustomElevatedButton(
//                     onPressed: () {
//                        login();
//                     },
//                     text: 'Login',
//                   ),
//                   SizedBox(height: height * 0.015),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("Don't have an account?"),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pushNamed(AppRoutes.registerScreen);
//                         },
//                         child: Text(
//                           'Create Account',
//                           style: AppTextStyle.bold16Purple.copyWith(
//                             decoration: TextDecoration.underline,
//                             decorationColor: AppColors.purpleColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: height * 0.015),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Divider(
//                           color: AppColors.outlineGrey,
//                           indent: width * 0.04,
//                           endIndent: width * 0.03,
//                         ),
//                       ),
//                       Text(
//                         'Or',
//                         style: AppTextStyle.normal16Grey,
//                       ),
//                       Expanded(
//                         child: Divider(
//                           color: AppColors.outlineGrey,
//                           indent: width * 0.04,
//                           endIndent: width * 0.03,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: height * 0.02),
//                   CustomElevatedButton(
//                     onPressed: () {
//
//                       // login with google
//                       signInWithGoogle();
//                       Navigator.pushNamedAndRemoveUntil(
//                         context,
//                         AppRoutes.mainWrapperScreen, // ← was homeScreenRoute
//                             (route) => false,
//                       );
//                       },
//                     hasIcon: true,
//                     borderSideColor: AppColors.purpleColor,
//                     backgroundColor: AppColors.transparentColor,
//                     customInButton: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.g_mobiledata, size: 26),
//                         SizedBox(width: width * 0.02),
//                         Text(
//                           'Login with Google',
//                           style: AppTextStyle.bold16Purple,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: height * 0.02),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   void login() async {
//
//     if (formKey.currentState!.validate()) {
//
//       FocusScope.of(context).unfocus();
//
//       try {
//
//         DialogUtlis.loadingDialog(context);
//
//         // Firebase Login
//         final credential = await authService.login(
//           email: emailController.text,
//           password: passwordController.text,
//         );
//
//         // Read User From Firestore
//         var user =
//         await FireBaseUtils.readUserFromFireStore(
//           credential.user?.uid ?? '',
//         );
//
//         if (user == null) {
//
//           DialogUtlis.hideDialog(context);
//
//           DialogUtlis.showDialogMessage(
//             context: context,
//             title: 'Error',
//             middleText: 'User not found',
//             buttonText: 'OK',
//           );
//
//           return;
//         }
//
//         // Save User In Provider
//         var userProvider =
//         Provider.of<MyUsersProvider>(
//           context,
//           listen: false,
//         );
//
//         userProvider.updateUsers(user);
//
//         DialogUtlis.hideDialog(context);
//
//         // Success Dialog
//         DialogUtlis.showDialogMessage(
//           context: context,
//           middleText: 'Login Successfully',
//           buttonText: 'OK',
//
//           onButtonPressed: () {
//
//             Navigator.pushNamedAndRemoveUntil(
//               context,
//               AppRoutes.mainWrapperScreen,
//                   (route) => false,
//             );
//           },
//         );
//
//       } on FirebaseAuthException catch (error) {
//         print('🔴 Firebase Error Code: ${error.code}');
//         print('🔴 Firebase Error Message: ${error.message}');
//
//         DialogUtlis.hideDialog(context);
//
//         String message =
//             'Something went wrong';
//
//         if (error.code == 'invalid-credential') {
//
//           message =
//           'The email or password is incorrect';
//         }
//
//         if (error.code == 'user-not-found') {
//
//           message = 'User not found';
//         }
//
//         if (error.code == 'wrong-password') {
//
//           message = 'Wrong password';
//         }
//
//         DialogUtlis.showDialogMessage(
//           context: context,
//           title: 'Error',
//           middleText: message,
//           buttonText: 'OK',
//         );
//
//       } catch (error) {
//
//         DialogUtlis.hideDialog(context);
//
//         DialogUtlis.showDialogMessage(
//           context: context,
//           title: 'Error',
//           middleText: error.toString(),
//           buttonText: 'OK',
//         );
//       }
//     }
//   }
//   Future<void> signInWithGoogle() async {
//     try {
//       DialogUtlis.loadingDialog(context);
//
//       // Sign out first to force the account picker to appear
//       await GoogleSignIn().signOut();
//
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) {
//         DialogUtlis.hideDialog(context);
//         return;
//       }
//
//       final GoogleSignInAuthentication? googleAuth =
//       await googleUser.authentication;
//
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//
//       // ✅ Only one signInWithCredential call
//       final userCredential =
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       final firebaseUser = userCredential.user;
//
//       MyUsers? user =
//       await FireBaseUtils.readUserFromFireStore(firebaseUser!.uid);
//       if (user == null) {
//         user = MyUsers(
//           id: firebaseUser.uid,
//           name: firebaseUser.displayName ?? '',
//           email: firebaseUser.email ?? '',
//         );
//       }
//
//       final userProvider =
//       Provider.of<MyUsersProvider>(context, listen: false);
//       userProvider.updateUsers(user);
//
//       DialogUtlis.hideDialog(context);
//       DialogUtlis.showDialogMessage(
//         context: context,
//         middleText: 'Login Successfully with Google',
//         buttonText: 'OK',
//         onButtonPressed: () {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             AppRoutes.homeScreenRoute,
//                 (route) => false,
//           );
//         },
//       );
//     } catch (e) {
//       DialogUtlis.hideDialog(context);
//       DialogUtlis.showDialogMessage(
//         title: 'Error',
//         context: context,
//         middleText: e.toString(),
//         middleTextStyle: AppTextStyle.bold16Red,
//         buttonText: 'OK',
//       );
//     }
//   }
//
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:provider/provider.dart';
import 'package:quiz_app_flutter/utlis/app_assets .dart';
import 'package:quiz_app_flutter/utlis/app_text.dart';
import 'package:quiz_app_flutter/widget/custom_text_form_field .dart';

import '../../../core/services/auth_service.dart';
import '../../../firebase_utils.dart';
import '../../../models/user_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../utlis/app_colors.dart';
import '../../../utlis/app_routes .dart';
import '../../../utlis/dialog_utlis.dart';
import '../../../widget/custom_elevated_button .dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = AuthService();
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(
      text: 'arsheel@gmail.com');
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
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: height * 0.05),
            Image.asset(AppAssets.logo),
            SizedBox(height: height * 0.05),
            Text('Welcome Back', style: AppTextStyle.bold32Black),
            SizedBox(height: height * 0.01),
            Text(
              'Please enter your details to sign in to your account.',
              style: AppTextStyle.normal16Grey,
            ),
            SizedBox(height: height * 0.04),
            Text('Email', style: AppTextStyle.medium14Black),
            SizedBox(height: height * 0.01),
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
                      if (text == 'admin') return null; // allow admin bypass
                      final bool emailValid = RegExp(
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
                      Icons.lock,
                      color: AppColors.greyColor,
                      size: 24,
                    ),
                    hintText: 'Password',
                    hintStyle: AppTextStyle.normal16Grey,
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
                        /// TODO: navigate to reset password screen
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
                      login();
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
                          Navigator.of(context)
                              .pushNamed(AppRoutes.registerScreen);
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
                      Text('Or', style: AppTextStyle.normal16Grey),
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

                  // ✅ FIX: removed the premature Navigator.push from onPressed.
                  // Navigation is now handled inside signInWithGoogle() only.
                  CustomElevatedButton(
                    onPressed: () {
                      signInWithGoogle();
                    },
                    hasIcon: true,
                    borderSideColor: AppColors.purpleColor,
                    backgroundColor: AppColors.transparentColor,
                    customInButton: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.g_mobiledata, size: 26),
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

  void login() async {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      var userProvider = Provider.of<MyUsersProvider>(context, listen: false);

      // --- ADMIN BYPASS ---
      if (emailController.text == 'admin' && passwordController.text == 'admin') {
        userProvider.setAdmin(true);
        // Create a dummy admin user model so the rest of the app doesn't crash on null
        userProvider.updateUsers(MyUsers(id: 'admin', name: 'Admin', email: 'admin'));
        Navigator.pushReplacementNamed(context, '/admin_dashboard');
        return;
      }
      // ---------------------

      try {
        DialogUtlis.loadingDialog(context);

        // Firebase Login
        final credential = await authService.login(
          email: emailController.text,
          password: passwordController.text,
        );

        // Read User From Firestore
        var user = await FireBaseUtils.readUserFromFireStore(
          credential.user?.uid ?? '',
        );

        if (user == null) {
          DialogUtlis.hideDialog(context);
          DialogUtlis.showDialogMessage(
            context: context,
            title: 'Error',
            middleText: 'User not found',
            buttonText: 'OK',
          );
          return;
        }

        // Save User In Provider
        userProvider.updateUsers(user);
        userProvider.setAdmin(false);

        DialogUtlis.hideDialog(context);

        // Success Dialog
        DialogUtlis.showDialogMessage(
          context: context,
          middleText: 'Login Successfully',
          buttonText: 'OK',
          onButtonPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.mainWrapperScreen,
                  (route) => false,
            );
          },
        );
      } on FirebaseAuthException catch (error) {
        print('🔴 Firebase Error Code: ${error.code}');
        print('🔴 Firebase Error Message: ${error.message}');

        DialogUtlis.hideDialog(context);

        String message = 'Something went wrong';

        if (error.code == 'invalid-credential') {
          message = 'The email or password is incorrect';
        }
        if (error.code == 'user-not-found') {
          message = 'User not found';
        }
        if (error.code == 'wrong-password') {
          message = 'Wrong password';
        }

        DialogUtlis.showDialogMessage(
          context: context,
          title: 'Error',
          middleText: message,
          buttonText: 'OK',
        );
      } catch (error) {
        DialogUtlis.hideDialog(context);
        DialogUtlis.showDialogMessage(
          context: context,
          title: 'Error',
          middleText: error.toString(),
          buttonText: 'OK',
        );
      }
    }
  }

  Future<void> signInWithGoogle() async {
    // ✅ FIX 1: Guard against unmounted widget before any async work
    if (!mounted) return;

    try {
      DialogUtlis.loadingDialog(context);

      // ✅ FIX 2: Sign out first to always force the account picker
      await GoogleSignIn().signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // ✅ FIX 3: User cancelled — hide dialog and return early
      if (googleUser == null) {
        if (mounted) DialogUtlis.hideDialog(context);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // ✅ FIX 4: Validate tokens before using them
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        if (mounted) {
          DialogUtlis.hideDialog(context);
          DialogUtlis.showDialogMessage(
            context: context,
            title: 'Error',
            middleText: 'Google authentication failed. Please try again.',
            buttonText: 'OK',
          );
        }
        return;
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // ✅ FIX 5: Single signInWithCredential call
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        if (mounted) {
          DialogUtlis.hideDialog(context);
          DialogUtlis.showDialogMessage(
            context: context,
            title: 'Error',
            middleText: 'Failed to get user info from Google.',
            buttonText: 'OK',
          );
        }
        return;
      }

      // Read or create user in Firestore
      MyUsers? user =
      await FireBaseUtils.readUserFromFireStore(firebaseUser.uid);

      if (user == null) {
        user = MyUsers(
          id: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
        );
        // ✅ FIX 6: Save new Google user to Firestore so future reads succeed
        await FireBaseUtils.addUserToFireStore(user);
      }

      // ✅ FIX 7: Check mounted before using context after all awaits
      if (!mounted) return;

      final userProvider = Provider.of<MyUsersProvider>(context, listen: false);
      userProvider.updateUsers(user);

      DialogUtlis.hideDialog(context);

      DialogUtlis.showDialogMessage(
        context: context,
        middleText: 'Login Successfully with Google',
        buttonText: 'OK',
        // ✅ FIX 8: Use mainWrapperScreen — consistent with email login route
        onButtonPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.mainWrapperScreen,
                (route) => false,
          );
        },
      );
    } on FirebaseAuthException catch (error) {
      print('🔴 Google Firebase Error Code: ${error.code}');
      print('🔴 Google Firebase Error Message: ${error.message}');

      if (!mounted) return;
      DialogUtlis.hideDialog(context);

      String message = 'Something went wrong';
      if (error.code == 'account-exists-with-different-credential') {
        message = 'An account already exists with a different sign-in method.';
      } else if (error.code == 'invalid-credential') {
        message = 'Invalid Google credential. Please try again.';
      }

      DialogUtlis.showDialogMessage(
        context: context,
        title: 'Error',
        middleText: message,
        buttonText: 'OK',
      );
    } catch (e) {
      print('🔴 Google Sign-In Error: $e');
      if (!mounted) return;
      DialogUtlis.hideDialog(context);
      DialogUtlis.showDialogMessage(
        title: 'Error',
        context: context,
        middleText: e.toString(),
        middleTextStyle: AppTextStyle.bold16Red,
        buttonText: 'OK',
      );
    }
  }
}