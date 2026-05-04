import 'package:flutter/material.dart';

import '../../../../../utlis/app_colors.dart';
import '../../../../../utlis/app_text.dart';

class QuizOptionItem extends StatelessWidget {
  final String letter;
  final String text;
  final bool isSelected;

  const QuizOptionItem({
    super.key,
    required this.letter,
    required this.text,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.02),
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.lightPrimaryColor : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : AppColors.borderColor,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.05),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: width * 0.1,
            height: width * 0.1,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : AppColors.lightGreyColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.transparent : AppColors.borderColor,
                width: 1,
              ),
            ),
            child: Text(
              letter,
              style: isSelected ? AppTextStyle.medium14White : AppTextStyle.medium14Grey,
            ),
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Text(
              text,
              style: isSelected ? AppTextStyle.medium16Black : AppTextStyle.medium16Black,
            ),
          ),
          if (isSelected)
            Icon(
              Icons.check_circle,
              color: AppColors.primaryColor,
              size: width * 0.07,
            ),
        ],
      ),
    );
  }
}