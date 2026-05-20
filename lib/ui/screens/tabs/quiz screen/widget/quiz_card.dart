import 'package:flutter/material.dart';
import '../../../../../utlis/app_colors.dart';
import '../../../../../utlis/app_text.dart';

class QuizCard extends StatelessWidget {
  final String title;
  final String difficulty;
  final String category;
  final String duration;
  final String description;
  final Color difficultyColor;
  final VoidCallback? onStartQuiz;   // NEW: callback for when Start Quiz is tapped

  const QuizCard({
    super.key,
    required this.title,
    required this.difficulty,
    required this.category,
    required this.duration,
    required this.description,
    required this.difficultyColor,
    this.onStartQuiz,               // NEW: optional so old usages don't break
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.02),
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(color: AppColors.surfaceColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.medium22Black,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: width * 0.01,
                ),
                decoration: BoxDecoration(
                  color: difficultyColor,
                  borderRadius: BorderRadius.circular(width * 0.05),
                ),
                child: Text(difficulty, style: AppTextStyle.medium12Black),
              ),
            ],
          ),
          SizedBox(height: height * 0.01),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: width * 0.01,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceColor,
                  borderRadius: BorderRadius.circular(width * 0.01),
                ),
                child: Text(category, style: AppTextStyle.medium12Black),
              ),
              SizedBox(width: width * 0.03),
              Icon(Icons.schedule, size: width * 0.04, color: AppColors.greyColor),
              SizedBox(width: width * 0.01),
              Text(duration, style: AppTextStyle.regular14Grey),
            ],
          ),
          SizedBox(height: height * 0.015),
          Text(
            description,
            style: AppTextStyle.regular14Grey,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: height * 0.01),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              // CHANGED: was () {} — now calls the callback from the screen
              onPressed: onStartQuiz,
              label: const Icon(Icons.arrow_forward, size: 18),
              icon: Text('Start Quiz', style: AppTextStyle.medium14Primary),
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
            ),
          ),
        ],
      ),
    );
  }
}