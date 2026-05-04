import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/ui/screens/auth/login_screen.dart';
import 'package:quiz_app_flutter/ui/screens/auth/register_screen.dart';
import 'package:quiz_app_flutter/ui/screens/nav_bar_screen.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/home%20screen/home_screen.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/profile%20screen/profile_screen.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/quiz_focus_screen.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/quiz_result_screen.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/quizzes_screen.dart';
import 'package:quiz_app_flutter/utlis/app_routes%20.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginScreen,
      routes: {
        AppRoutes.loginScreen: (context) => LoginScreen(),
        AppRoutes.registerScreen: (context) => RegisterScreen(),
        AppRoutes.mainWrapperScreen: (context) => mainWrapperScreen(),
        AppRoutes.homeScreenRoute: (context) => HomeScreen(),
        AppRoutes.quizzesScreen : (context) =>  QuizzesHomeScreen(),
        AppRoutes.profileTabScreen : (context) => ProfileScreen(),
        AppRoutes.quizFocusScreen : (context) => QuizFocusScreen(),
         AppRoutes.quizResultScreen : (context) => QuizResultScreen(),
      },
    );
  }
}

