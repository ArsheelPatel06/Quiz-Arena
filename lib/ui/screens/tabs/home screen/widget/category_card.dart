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
      height: width * 0.35,
      margin: EdgeInsets.only(right: width * 0.04),
      padding: EdgeInsets.all(width * 0.02),
      decoration: BoxDecoration(
        color: color,
        gradient: LinearGradient(
          colors: [color.withOpacity(0.7), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(width * 0.05),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: width * 0.12),
          SizedBox(height: width * 0.03),
          Text(
            label, 
            style: AppTextStyle.label14OnSurface.copyWith(
              color: Colors.white, 
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
