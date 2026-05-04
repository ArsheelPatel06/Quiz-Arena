import 'package:flutter/material.dart';

import '../../../../../utlis/app_colors.dart';
import '../../../../../utlis/app_text.dart';

class CategoryCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final double width;

  const CategoryCard({super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.35,
      margin: EdgeInsets.only(right: width * 0.04),
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(color: AppColors.outlineVariantColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(width * 0.02),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: width * 0.07),
          ),
          SizedBox(height: width * 0.04),
          Text(label, style: AppTextStyle.label14OnSurface),
        ],
      ),
    );
  }
}
