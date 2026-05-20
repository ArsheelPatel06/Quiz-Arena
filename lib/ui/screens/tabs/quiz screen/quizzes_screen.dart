import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/widget/filter_chip_item.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/quiz%20screen/widget/quiz_card.dart';
import 'package:quiz_app_flutter/utlis/app_routes%20.dart';
import '../../../../providers/quiz_provider.dart';
import '../../../../utlis/app_colors.dart';
import '../../../../utlis/app_text.dart';

class QuizzesHomeScreen extends StatefulWidget {
  final String categoryId;

  const QuizzesHomeScreen({super.key, required this.categoryId});

  @override
  State<QuizzesHomeScreen> createState() => _QuizzesHomeScreenState();
}

class _QuizzesHomeScreenState extends State<QuizzesHomeScreen> {

  // ── NEW: track which filter is selected ──────────────────
  // Default is 'All' — shows every quiz with no filtering
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<QuizProvider>(context, listen: false)
          .loadQuizzes(widget.categoryId);
    });
  }

  void _onStartQuizTapped(Map<String, dynamic> quiz) async {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);

    final String quizId = quiz['id'];
    final String? quizCategoryId = quiz['categoryId'] as String?;

    await quizProvider.loadQuestions(
      quizId,
      categoryId: quizCategoryId,
    );

    if (!mounted) return;

    Navigator.of(context).pushNamed(AppRoutes.quizFocusScreen);
  }

  // ── NEW: filter the quizzes list based on selected chip ──
  // If 'All' is selected → return everything
  // If 'Easy' / 'Medium' / 'Hard' → return only matching quizzes
  List<Map<String, dynamic>> _getFilteredQuizzes(
      List<Map<String, dynamic>> allQuizzes) {
    if (_selectedFilter == 'All') {
      return allQuizzes; // no filter, show everything
    }

    return allQuizzes.where((quiz) {
      // quiz['difficulty'] comes from Firestore
      // We compare it to the selected chip label
      final difficulty = quiz['difficulty'] ?? 'Medium';
      return difficulty == _selectedFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    var quizProvider = Provider.of<QuizProvider>(context);

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

              // ── CHANGED: Filter Chips now have onTap ────────────
              // When the user taps a chip:
              //   1. setState() updates _selectedFilter
              //   2. Flutter rebuilds the widget
              //   3. _buildQuizList runs again with the new filter
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Easy', 'Medium', 'Hard'].map((label) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilter = label; // update selected chip
                        });
                      },
                      child: FilterChipItem(
                        label: label,
                        isSelected: _selectedFilter == label, // highlight active chip
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: height * 0.03),

              _buildQuizList(quizProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuizList(QuizProvider quizProvider) {
    if (quizProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (quizProvider.errorMessage != null) {
      return Text(
        quizProvider.errorMessage!,
        style: const TextStyle(color: Colors.red),
      );
    }

    // ── CHANGED: apply filter before building cards ──────────
    // filteredQuizzes is a subset of quizProvider.quizzes
    // based on the currently selected chip
    final filteredQuizzes = _getFilteredQuizzes(quizProvider.quizzes);

    if (filteredQuizzes.isEmpty) {
      return Center(
        child: Text('No $_selectedFilter quizzes found.'),
      );
    }

    return Column(
      children: filteredQuizzes.map((quiz) {
        return QuizCard(
          title: quiz['title'] ?? 'Untitled Quiz',
          difficulty: quiz['difficulty'] ?? 'Medium',
          category: quiz['category'] ?? 'General',
          duration: quiz['duration'] ?? 'N/A',
          description: quiz['description'] ?? 'No description available.',
          difficultyColor: _getDifficultyColor(quiz['difficulty']),
          onStartQuiz: () => _onStartQuizTapped(quiz),
        );
      }).toList(),
    );
  }

  Color _getDifficultyColor(String? difficulty) {
    switch (difficulty) {
      case 'Easy':
        return AppColors.surfaceColor;
      case 'Hard':
        return AppColors.redColor.withOpacity(0.2);
      case 'Medium':
      default:
        return AppColors.primaryContainerColor;
    }
  }
}