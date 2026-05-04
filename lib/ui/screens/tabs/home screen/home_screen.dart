import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/home%20screen/widget/category_card.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/home%20screen/widget/quiz_list_item.dart';
import '../../../../utlis/app_colors.dart';
import '../../../../utlis/app_text.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back', style: AppTextStyle.body14OnSurfaceVariant),
            Text('Hello, Alex!', style: AppTextStyle.headline28OnSurface),
            SizedBox(height: height * 0.03),
            _buildProgressCard(width, height),
            SizedBox(height: height * 0.03),
            Text('Categories', style: AppTextStyle.title22OnSurface),
            SizedBox(height: height * 0.015),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryCard(
                    label: 'Math',
                    icon: Icons.calculate,
                    color: AppColors.primaryColor,
                    width: width,
                  ),
                  CategoryCard(
                    label: 'Science',
                    icon: Icons.science,
                    color: AppColors.secondaryContainerColor,
                    width: width,
                  ),
                  CategoryCard(
                    label: 'Programming',
                    icon: Icons.code,
                    color: AppColors.tertiaryContainerColor,
                    width: width,
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Quizzes', style: AppTextStyle.title22OnSurface),
                Text('View All', style: AppTextStyle.label12OnSurfaceVariant.copyWith(color: AppColors.primaryColor)),
              ],
            ),
            SizedBox(height: height * 0.015),
            const QuizListItem(
              title: 'Algebra Basics',
              subtitle: 'Math • 10 Questions',
              score: '80%',
              date: 'Yesterday',
              icon: Icons.functions,
            ),
            const QuizListItem(
              title: 'Cell Structure',
              subtitle: 'Science • 15 Questions',
              score: '95%',
              date: '2 days ago',
              icon: Icons.biotech,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard(double width, double height) {
    return Container(
      padding: EdgeInsets.all(width * 0.05),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(color: AppColors.outlineVariantColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Weekly Progress', style: AppTextStyle.title22OnSurface),
                SizedBox(height: height * 0.01),
                Text("You're on a 4-day streak! Keep up the great work.", style: AppTextStyle.body14OnSurfaceVariant),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: width * 0.18,
                height: width * 0.18,
                child: CircularProgressIndicator(
                  value: 0.75,
                  strokeWidth: width * 0.025,
                  backgroundColor: AppColors.secondaryContainerColor,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              ),
              Text('75%', style: AppTextStyle.label14Primary),
            ],
          ),
        ],
      ),
    );
  }
}



