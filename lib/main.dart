import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter/providers/auth_provider.dart';
import 'package:quiz_app_flutter/providers/quiz_provider.dart'; // ← NEW: import QuizProvider
import 'package:quiz_app_flutter/ui/screens/admin/admin_dashboard_screen.dart';
import 'package:quiz_app_flutter/splash%20screen/splash_screen.dart';
import 'package:quiz_app_flutter/ui/screens/auth/login_screen.dart';
import 'package:quiz_app_flutter/ui/screens/auth/register_screen.dart';
import 'package:quiz_app_flutter/ui/screens/nav_bar_screen.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/home%20screen/home_screen.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/profile%20screen/profile_screen.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/quiz_focus_screen.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/quiz_result_screen.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/quizzes_screen.dart';
import 'package:quiz_app_flutter/ui/screens/leaderboard_screen.dart';
import 'package:quiz_app_flutter/utlis/app_routes%20.dart';
import 'package:quiz_app_flutter/seed_data.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  // Makes sure Flutter is ready before we call any native code (Firebase)
  WidgetsFlutterBinding.ensureInitialized();

  // Connect Flutter to your Firebase project manually
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCZLQp-vlnitoU7gd0TYPePmBmsCw9SD7Q",
      authDomain: "quiz-arena-28a56.firebaseapp.com",
      projectId: "quiz-arena-28a56",
      storageBucket: "quiz-arena-28a56.firebasestorage.app",
      messagingSenderId: "293930438066",
      appId: "1:293930438066:web:800d418d93a3ff7e4368ab",
      measurementId: "G-6LL5KJ61N1",
    ),
  );

  // Automatically seed data for demo
  await DatabaseSeeder.seedTechTrivia();

  // MultiProvider makes BOTH providers available to every screen in the app.
  // Think of it as a box sitting above the whole widget tree.
  // Any screen can reach in and grab MyUsersProvider OR QuizProvider.
  runApp(MultiProvider(
    providers: [
      // Handles login / register / logout (already existed)
      ChangeNotifierProvider(create: (context) => MyUsersProvider()),

      // ── NEW ──────────────────────────────────────────────
      // Handles categories, quizzes, questions, quiz logic, and results.
      // Created once here so it lives for the entire app session.
      ChangeNotifierProvider(create: (context) => QuizProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizArena',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute:
      // AppRoutes.loginScreen
      '/'
      ,

      routes: {
        '/' : (context) => QuizMasterSplash(),
        AppRoutes.loginScreen: (context) => LoginScreen(),
        '/admin_dashboard': (context) => const AdminDashboardScreen(),
        AppRoutes.registerScreen: (context) => RegisterScreen(),
        AppRoutes.mainWrapperScreen: (context) => mainWrapperScreen(),
        AppRoutes.homeScreenRoute: (context) => HomeScreen(),
        AppRoutes.quizzesScreen: (context) {
          // Read the categoryId that was passed when navigating to this screen
          final categoryId = ModalRoute.of(context)!.settings.arguments as String;
          return QuizzesHomeScreen(categoryId: categoryId);
        },
        AppRoutes.profileTabScreen : (context) => ProfileScreen(),
        AppRoutes.quizFocusScreen : (context) => QuizFocusScreen(),
        AppRoutes.quizResultScreen : (context) => QuizResultScreen(),
        AppRoutes.leaderboardScreen: (context) {
          final quizId = ModalRoute.of(context)!.settings.arguments as String;
          return LeaderboardScreen(quizId: quizId);
        },
      },
    );
  }
}