import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/widget/filter_chip_item.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/widget/quiz_card.dart';
import 'package:quiz_app_flutter/utlis/app_routes%20.dart';
import '../../../../utlis/app_colors.dart';
import '../../../../utlis/app_text.dart';

class QuizzesHomeScreen extends StatelessWidget {
  const QuizzesHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                height: height * 0.06,
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.surfaceColor,
                  borderRadius: BorderRadius.circular(width * 0.1),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: AppColors.greyColor,
                      size: width * 0.06,
                    ),
                    SizedBox(width: width * 0.02),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search quizzes...',
                          hintStyle: AppTextStyle.regular14Grey,
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),

              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChipItem(label: 'All', isSelected: true),
                    FilterChipItem(label: 'Easy'),
                    FilterChipItem(label: 'Medium'),
                    FilterChipItem(label: 'Hard'),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),

              // Quiz List
              QuizCard(
                title: 'Advanced Algebra Concepts',
                difficulty: 'Medium',
                category: 'Mathematics',
                duration: '15 mins',
                description: 'Test your knowledge on complex algebraic equations, polynomials, and quadratic functions.',
                difficultyColor: AppColors.primaryContainerColor,
              ),
              QuizCard(
                title: 'Cellular Biology Basics',
                difficulty: 'Easy',
                category: 'Science',
                duration: '10 mins',
                description: 'A fundamental review of cell structure, organelles, and basic biological processes.',
                difficultyColor: AppColors.surfaceColor,
              ),
              QuizCard(
                title: 'World War II European Theater',
                difficulty: 'Hard',
                category: 'History',
                duration: '25 mins',
                description: 'Deep dive into the major campaigns, strategic decisions, and key figures of the European conflict.',
                difficultyColor: AppColors.redColor.withOpacity(0.2),
              ),
              InkWell(onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.quizFocusScreen);
              },
                child: QuizCard(
                  title: 'Introduction to Python',
                  difficulty: 'Easy',
                  category: 'Computer Science',
                  duration: '12 mins',
                  description: 'Learn the basics of Python syntax, variables, and simple data structures.',
                  difficultyColor: AppColors.surfaceColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
