import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui/screens/auth/login_screen.dart';
import '../utlis/app_colors.dart';
import '../utlis/app_text.dart';



class QuizMasterSplash extends StatelessWidget {
  const QuizMasterSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      duration: const Duration(milliseconds: 3000),
      nextScreen: const LoginScreen(),
      backgroundColor: AppColors.primaryColor,
      // 2. Change 'buildCustomScreen: () =>' to 'splashScreenBody:'
      splashScreenBody: const SplashScreenBody(),
    );
  }
}

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    // We cache these once to avoid repeated lookups
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          // 1. Optimized background using Gradients instead of BackdropFilter
          const OptimizedBackground(),

          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 2. RepaintBoundary isolates the logo animation/rendering
                  const RepaintBoundary(child: SplashLogo()),
                  SizedBox(height: size.height * 0.04),
                  Text(
                    'QuizArena',
                    style: AppTextStyle.bold57White,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'Ignite your knowledge',
                    style: AppTextStyle.regular16FixedDim,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SplashLoadingIndicator(),
        ],
      ),
    );
  }
}

class OptimizedBackground extends StatelessWidget {
  const OptimizedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top Left Glow
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.8, -0.8),
                radius: 1.2,
                colors: [
                  AppColors.secondaryGradientColor,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        // Bottom Right Glow
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.8, 0.8),
                radius: 1.2,
                colors: [
                  AppColors.inversePrimaryGradientColor,
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Container(
      width: width * 0.32,
      height: width * 0.32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.whiteColor.withOpacity(0.1),
        border: Border.all(
          color: AppColors.whiteColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.lightbulb,
          size: width * 0.16,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}

class SplashLoadingIndicator extends StatelessWidget {
  const SplashLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Positioned(
      bottom: size.height * 0.08,
      left: 0,
      right: 0,
      child: Center(
        child: SizedBox(
          width: size.width * 0.48,
          child: const LinearProgressIndicator(
            backgroundColor: AppColors.trackColor,
            color: AppColors.whiteColor,
            minHeight: 6,
          ),
        ),
      ),
    );
  }
}