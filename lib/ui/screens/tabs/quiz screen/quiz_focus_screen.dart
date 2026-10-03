import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/widget/quiz_option_item.dart';
import 'package:quiz_app_flutter/utlis/app_routes%20.dart';

import '../../../../providers/quiz_provider.dart';
import '../../../../utlis/app_colors.dart';
import '../../../../utlis/app_text.dart';

class QuizFocusScreen extends StatefulWidget {
  const QuizFocusScreen({super.key});

  @override
  State<QuizFocusScreen> createState() => _QuizFocusScreenState();
}

class _QuizFocusScreenState extends State<QuizFocusScreen> {

  // ───────────────── Timer Settings ─────────────────

  static const int _totalSeconds = 15;

  late int remainingTime;

  Timer? _timer;

  bool _isMoving = false;

  // ───────────────── Init ─────────────────

  @override
  void initState() {
    super.initState();
    remainingTime = _totalSeconds;
    _startTimer();
  }

  // ───────────────── Timer Logic ─────────────────

  void _startTimer() {

    // Always cancel the old timer before creating a new one
    _stopTimer();

    // Reset the counter and repaint BEFORE the first tick fires,
    // so there is no visual flash of the previous question's remaining time
    if (mounted) {
      setState(() => remainingTime = _totalSeconds);
    } else {
      remainingTime = _totalSeconds;
    }

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        // ASSIGNMENT DEMO - Timer
        if (remainingTime > 0) {
          setState(() => remainingTime--);
        } else {
          timer.cancel();
          _onNextPressed(timedOut: true); // acts as nextQuestion()
        }
      },
    );
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  // ───────────────── Dispose ─────────────────

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  // ───────────────── Format Time ─────────────────

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:'
        '${secs.toString().padLeft(2, '0')}';
  }

  // ───────────────── Next Question ─────────────────

  void _onNextPressed({bool timedOut = false}) {

    // Prevent double-tap or double timer fire
    if (_isMoving) return;
    _isMoving = true;

    // Stop the timer FIRST — before any state changes or navigation —
    // so a pending periodic tick cannot call _onNextPressed a second time
    _stopTimer();

    final quizProvider =
    Provider.of<QuizProvider>(context, listen: false);

    final bool hasNext = quizProvider.nextQuestion();

    if (!hasNext) {

      if (!mounted) {
        _isMoving = false;
        return;
      }

      Navigator.of(context).pushNamed(AppRoutes.quizResultScreen);

      // Do not reset _isMoving here — the screen is being replaced anyway

    } else {

      // Reset the guard BEFORE restarting the timer so the new
      // periodic callback starts with a clean state
      _isMoving = false;

      _startTimer();
    }
  }

  // ───────────────── Select Answer ─────────────────

  void _onOptionTapped(int answerIndex) {

    final quizProvider =
    Provider.of<QuizProvider>(context, listen: false);

    quizProvider.selectAnswer(
      quizProvider.currentQuestionIndex,
      answerIndex,
    );
  }

  // ───────────────── UI ─────────────────

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height;
    final width  = MediaQuery.sizeOf(context).width;

    final quizProvider = Provider.of<QuizProvider>(context);

    if (quizProvider.currentQuestion == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = quizProvider.currentQuestion!;

    final currentIndex    = quizProvider.currentQuestionIndex;
    final totalQuestions  = quizProvider.questions.length;

    final selectedAnswerIndex =
    quizProvider.selectedAnswers[currentIndex];

    final double progressFraction =
        (currentIndex + 1) / totalQuestions;

    // Timer badge turns red when 5 seconds or fewer remain
    final bool isAlmostUp = remainingTime <= 5;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width  * 0.04,
            vertical:   height * 0.03,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // ───────────────── Header ─────────────────

              Row(
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [

                  Text(
                    'Question ${currentIndex + 1} of $totalQuestions',
                    style: AppTextStyle.medium14Grey,
                  ),

                  // Timer badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width  * 0.03,
                      vertical:   height * 0.008,
                    ),

                    decoration: BoxDecoration(
                      color: isAlmostUp
                          ? Colors.red.withOpacity(0.1)
                          : AppColors.lightGreyColor,

                      borderRadius: BorderRadius.circular(width * 0.05),

                      border: Border.all(
                        color: isAlmostUp
                            ? Colors.red
                            : AppColors.borderColor,
                        width: 1,
                      ),
                    ),

                    child: Row(
                      children: [

                        Icon(
                          Icons.timer_outlined,
                          color: isAlmostUp
                              ? Colors.red
                              : AppColors.primaryColor,
                          size: width * 0.045,
                        ),

                        SizedBox(width: width * 0.015),

                        Text(
                          _formatTime(remainingTime),
                          style: AppTextStyle.medium14Black.copyWith(
                            color: isAlmostUp ? Colors.red : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.01),

              // ───────────────── Progress Bar ─────────────────

              Container(
                height: height * 0.008,
                width:  double.infinity,

                decoration: BoxDecoration(
                  color:        AppColors.borderColor,
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),

                child: FractionallySizedBox(
                  alignment:   Alignment.centerLeft,
                  widthFactor: progressFraction,

                  child: Container(
                    decoration: BoxDecoration(
                      color:        AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                  ),
                ),
              ),

              SizedBox(height: height * 0.04),

              // ───────────────── Question ─────────────────

              Text(
                question.text,
                style: AppTextStyle.medium28Black,
              ),

              SizedBox(height: height * 0.04),

              // ───────────────── Options ─────────────────

              Expanded(
                child: ListView.builder(
                  physics:   const BouncingScrollPhysics(),
                  itemCount: question.options.length,

                  itemBuilder: (context, index) {

                    final letter = String.fromCharCode(65 + index);

                    final isSelected = selectedAnswerIndex == index;

                    return GestureDetector(
                      onTap: () => _onOptionTapped(index),

                      child: QuizOptionItem(
                        letter:     letter,
                        text:       question.options[index],
                        isSelected: isSelected,
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: height * 0.02),

              // ───────────────── Next Button ─────────────────

              InkWell(
                onTap: _onNextPressed,
                borderRadius: BorderRadius.circular(width * 0.1),

                child: Container(
                  width:  double.infinity,
                  height: height * 0.07,

                  decoration: BoxDecoration(
                    color:        AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(width * 0.1),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Text(
                        quizProvider.isLastQuestion
                            ? 'Finish'
                            : 'Next Question',
                        style: AppTextStyle.medium14White,
                      ),

                      SizedBox(width: width * 0.02),

                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.whiteColor,
                        size:  width * 0.05,
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