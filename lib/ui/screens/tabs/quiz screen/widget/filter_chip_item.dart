import 'package:flutter/material.dart';

import '../../../../../utlis/app_colors.dart';
import '../../../../../utlis/app_text.dart';

class FilterChipItem extends StatelessWidget {
  final String label;
  final bool isSelected;

  const FilterChipItem({
    super.key,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;

    return Container(
      margin: EdgeInsets.only(right: width * 0.02),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: width * 0.02,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryContainerColor : AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(width * 0.05),
        border: isSelected ? null : Border.all(color: AppColors.greyColor.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: AppTextStyle.medium14Black,
      ),
    );
  }
}
