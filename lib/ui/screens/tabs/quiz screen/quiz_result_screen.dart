import 'package:flutter/material.dart';
import 'package:provider/provider.dart';                              // NEW
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/widget/action_button.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/widget/stat_card.dart';
import '../../../../providers/quiz_provider.dart';                   // NEW
import '../../../../providers/auth_provider.dart';                   // NEW
import '../../../../utlis/app_colors.dart';
import '../../../../utlis/app_text.dart';
import '../../../../utlis/app_routes .dart';                         // NEW

// CHANGED: StatelessWidget → StatefulWidget
// Reason: we need initState() to save the result to Firestore when screen opens
class QuizResultScreen extends StatefulWidget {
  const QuizResultScreen({super.key});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {

  @override
  void initState() {
    super.initState();
    // Save the result to Firestore once when this screen opens
    Future.microtask(() => _saveResult());
  }

  void _saveResult() {
    var quizProvider = Provider.of<QuizProvider>(context, listen: false);
    var authProvider = Provider.of<MyUsersProvider>(context, listen: false);

    // Only save if a user is logged in
    if (authProvider.currentUser != null) {
      quizProvider.saveResult(authProvider.currentUser!.id);
    }
  }

  // Returns a message based on the percentage the user scored
  String _getResultMessage(double percentage) {
    if (percentage >= 80) return 'Excellent Work!';
    if (percentage >= 50) return 'Good Job!';
    return 'Keep Practicing!';
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    // listen: true → UI reads real data from provider
    var quizProvider = Provider.of<QuizProvider>(context);

    // Calculate values once so we can use them below
    final int score = quizProvider.calculateScore();
    final int total = quizProvider.questions.length;
    final int wrong = total - score;
    final double percentage = quizProvider.calculatePercentage();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.03,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: height * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(width * 0.06),
                  border: Border.all(
                    color: AppColors.borderColor.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.05),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDBleJHGedwTeBkLzfqLQmnJfvjOq45w_TRxO0MWiRB-cSYdgrJs1mSkeY6okhi8WQT7xF2wsmv93DCDTwoUJoB_yl_DWpeNlGOdAlbKHA-kCmnhPE6zou1AT8idIJvn88h5wW8dHY_OOhVoykUJ7shtAi0AvA5xf5jCUOuNYw0KklnvTYF-oPtLtjSaMQOAHkF8x3KCoISalyUPIV3xKEBP_eCvDTfsVPvpF-2VtiZJi9xiSnBKppDpoQlJPeoHHvJJ1Sb6FvBGlRW',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: AppColors.backgroundColor.withOpacity(0.9),
                    ),
                    Column(
                      children: [
                        Container(
                          width: width * 0.4,
                          height: width * 0.4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.lightPrimaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.backgroundColor,
                              width: width * 0.015,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.15),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          // CHANGED: was hardcoded '8/10' — now uses real score
                          child: Text(
                            '$score/$total',
                            style: AppTextStyle.regular57PrimaryDark,
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        // CHANGED: was hardcoded 'Excellent Work!' — now based on percentage
                        Text(
                          _getResultMessage(percentage),
                          style: AppTextStyle.bold32Primary,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          'You have successfully completed this assessment.',
                          style: AppTextStyle.regular14Grey,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              Row(
                children: [
                  StatCard(
                    title: 'Correct',
                    // CHANGED: was hardcoded '8' — now uses real score
                    value: '$score',
                    icon: Icons.check_circle,
                    iconColor: AppColors.primaryColor,
                    iconBgColor: AppColors.primaryColor,
                  ),
                  SizedBox(width: width * 0.03),
                  StatCard(
                    title: 'Wrong',
                    // CHANGED: was hardcoded '2' — now calculated (total - score)
                    value: '$wrong',
                    icon: Icons.cancel,
                    iconColor: AppColors.redColor,
                    iconBgColor: AppColors.redLightColor,
                  ),
                ],
              ),
              const Spacer(),
              // Review Answers — no logic yet, kept as-is
              ActionButton(
                text: 'Review Answers',
                icon: Icons.fact_check_outlined,
                backgroundColor: AppColors.primaryColor,
                textStyle: AppTextStyle.medium14White,
                iconColor: AppColors.whiteColor,
                onTap: () {},                                        // NEW param
              ),
              SizedBox(height: height * 0.015),
              // CHANGED: Retry resets quiz and goes back to quiz screen
              ActionButton(
                text: 'Retry Quiz',
                icon: Icons.refresh,
                backgroundColor: AppColors.secondaryLightColor,
                textStyle: AppTextStyle.medium14SecondaryDark,
                iconColor: AppColors.secondaryDarkColor,
                onTap: () {                                          // NEW param
                  Provider.of<QuizProvider>(context, listen: false).resetQuiz();
                  Navigator.of(context).pushNamed(AppRoutes.quizFocusScreen);
                },
              ),
              SizedBox(height: height * 0.015),
              ActionButton(
                text: 'Back to Home',
                icon: Icons.home_outlined,
                backgroundColor: AppColors.transparentColor,
                textStyle: AppTextStyle.medium14Primary,
                iconColor: AppColors.primaryColor,
                onTap: () {
                  // clearQuestions: true → clears old questions so home screen is clean
                  Provider.of<QuizProvider>(context, listen: false).resetQuiz(clearQuestions: true);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.mainWrapperScreen,
                        (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}