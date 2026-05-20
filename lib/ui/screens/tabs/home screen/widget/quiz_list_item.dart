import 'package:flutter/material.dart';

import '../../../../../utlis/app_colors.dart';
import '../../../../../utlis/app_text.dart';

class QuizListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String score;
  final String date;
  final IconData icon;

  const QuizListItem({
    required this.title,
    required this.subtitle,
    required this.score,
    required this.date,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;

    return Container(
      margin: EdgeInsets.only(bottom: width * 0.03),
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(color: AppColors.outlineVariantColor),
      ),
      child: Row(
        children: [
          Container(
            width: width * 0.12,
            height: width * 0.12,
            decoration: BoxDecoration(
              color: AppColors.surfaceColor,
              borderRadius: BorderRadius.circular(width * 0.02),
            ),
            child: Icon(icon, color: AppColors.onSurfaceVariantColor),
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyle.label14OnSurface),
                Text(subtitle, style: AppTextStyle.body14OnSurfaceVariant),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: width * 0.005),
                decoration: BoxDecoration(
                  color: AppColors.primaryFixedColor,
                  borderRadius: BorderRadius.circular(width * 0.05),
                ),
                child: Text(score, style: AppTextStyle.label14Primary),
              ),
              Text(date, style: AppTextStyle.label12OnSurfaceVariant),
            ],
          ),
        ],
      ),
    );
  }
}