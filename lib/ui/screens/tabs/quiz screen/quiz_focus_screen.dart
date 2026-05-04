import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/widget/quiz_option_item.dart';
import 'package:quiz_app_flutter/utlis/app_routes%20.dart';

import '../../../../utlis/app_colors.dart';
import '../../../../utlis/app_text.dart';



class QuizFocusScreen extends StatelessWidget {
  const QuizFocusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Question 2 of 10',
                    style: AppTextStyle.medium14Grey,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03,
                      vertical: height * 0.008,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyColor,
                      borderRadius: BorderRadius.circular(width * 0.05),
                      border: Border.all(color: AppColors.borderColor, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: AppColors.primaryColor,
                          size: width * 0.045,
                        ),
                        SizedBox(width: width * 0.015),
                        Text(
                          '00:15',
                          style: AppTextStyle.medium14Black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              Container(
                height: height * 0.008,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),
              Text(
                'What is the capital of France?',
                style: AppTextStyle.medium28Black,
              ),
              SizedBox(height: height * 0.04),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    QuizOptionItem(letter: 'A', text: 'London'),
                    QuizOptionItem(letter: 'B', text: 'Berlin'),
                    QuizOptionItem(letter: 'C', text: 'Paris', isSelected: true),
                    QuizOptionItem(letter: 'D', text: 'Madrid'),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              InkWell(
                onTap: () {
                  /// todo : nav to result screen
                  Navigator.of(context).pushNamed(AppRoutes.quizResultScreen);
                },
                borderRadius: BorderRadius.circular(width * 0.1),
                child: Container(
                  width: double.infinity,
                  height: height * 0.07,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(width * 0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next Question',
                        style: AppTextStyle.medium14White,
                      ),
                      SizedBox(width: width * 0.02),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.whiteColor,
                        size: width * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

