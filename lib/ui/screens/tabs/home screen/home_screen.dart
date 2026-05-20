import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/home%20screen/widget/category_card.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/home%20screen/widget/quiz_list_item.dart';
import '../../../../providers/quiz_provider.dart';
import '../../../../providers/auth_provider.dart';   // ← ADD THIS
import '../../../../utlis/app_colors.dart';
import '../../../../utlis/app_routes .dart';
import '../../../../utlis/app_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final quizProvider = context.read<QuizProvider>();
      final authProvider = context.read<MyUsersProvider>();

      // Load categories (already existed)
      quizProvider.loadCategories();

      // Load recent results if user is logged in  ← NEW
      final userId = authProvider.currentUser?.id;
      if (userId != null) {
        quizProvider.loadRecentResults(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    final quizProvider = context.watch<QuizProvider>();
    final authProvider = context.watch<MyUsersProvider>(); // ← ADD THIS

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back', style: AppTextStyle.body14OnSurfaceVariant),
            // ── CHANGE: use real user name instead of "Alex" ──
            Text(
              'Hello, ${authProvider.currentUser?.name ?? 'there'}!',
              style: AppTextStyle.headline28OnSurface,
            ),
            SizedBox(height: height * 0.03),
            _buildProgressCard(width, height, quizProvider),  // ← pass provider
            SizedBox(height: height * 0.03),
            Text('Categories', style: AppTextStyle.title22OnSurface),
            SizedBox(height: height * 0.015),
            _buildCategoriesRow(quizProvider, width),
            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Quizzes', style: AppTextStyle.title22OnSurface),
                Text('View All', style: AppTextStyle.label12OnSurfaceVariant.copyWith(color: AppColors.primaryColor)),
              ],
            ),
            SizedBox(height: height * 0.015),
            // ── CHANGE: replaced hardcoded items with real results ──
            _buildRecentResults(quizProvider),
          ],
        ),
      ),
    );
  }

  // ── NEW: builds real recent results ──────────────────────
  Widget _buildRecentResults(QuizProvider quizProvider) {
    // No results yet
    if (quizProvider.recentResults.isEmpty) {
      return const Text(
        'No quizzes taken yet. Start one!',
        style: TextStyle(color: Colors.grey),
      );
    }

    // Show each result as a QuizListItem
    return Column(
      children: quizProvider.recentResults.map((result) {
        final percent = result.percentage.toStringAsFixed(0);
        final date = _formatDate(result.date);

        return QuizListItem(
          title: 'Quiz',                          // you can store quiz name in ResultModel later
          subtitle: '${result.totalQuestions} Questions',
          score: '$percent%',
          date: date,
          icon: Icons.quiz,
        );
      }).toList(),
    );
  }

  // Simple helper to format date as "Today", "Yesterday", or a date string
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return '${date.day}/${date.month}/${date.year}';
  }

  // ── Categories row (unchanged logic) ─────────────────────
  Widget _buildCategoriesRow(QuizProvider quizProvider, double width) {
    if (quizProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (quizProvider.errorMessage != null) {
      return Text(quizProvider.errorMessage!, style: const TextStyle(color: Colors.red));
    }
    if (quizProvider.categories.isEmpty) {
      return const Text('No categories found.');
    }

    final colors = [
      AppColors.primaryColor,
      AppColors.secondaryContainerColor,
      AppColors.tertiaryContainerColor,
    ];
    final icons = [Icons.calculate, Icons.science, Icons.code, Icons.quiz];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(quizProvider.categories.length, (index) {
          final category = quizProvider.categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.quizzesScreen,
                arguments: category['id'],
              );
            },
            child: CategoryCard(
              label: category['name'] ?? 'Category',
              icon: icons[index % icons.length],
              color: colors[index % colors.length],
              width: width,
            ),
          );
        }),
      ),
    );
  }

  // ── Progress card — updated to use real data ──────────────
  Widget _buildProgressCard(double width, double height, QuizProvider quizProvider) {
    // Calculate average score from recent results
    double avgPercent = 0;
    if (quizProvider.recentResults.isNotEmpty) {
      final total = quizProvider.recentResults
          .fold(0.0, (sum, r) => sum + r.percentage);
      avgPercent = total / quizProvider.recentResults.length;
    }

    final displayPercent = avgPercent.toStringAsFixed(0);

    return Container(
      padding: EdgeInsets.all(width * 0.05),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(width * 0.03),
        border: Border.all(color: AppColors.outlineVariantColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Weekly Progress', style: AppTextStyle.title22OnSurface),
                SizedBox(height: height * 0.01),
                Text(
                  quizProvider.recentResults.isEmpty
                      ? 'Take a quiz to see your progress!'
                      : "You're doing great! Keep it up.",
                  style: AppTextStyle.body14OnSurfaceVariant,
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: width * 0.18,
                height: width * 0.18,
                child: CircularProgressIndicator(
                  // Use real average, or 0 if no results yet
                  value: avgPercent / 100,
                  strokeWidth: width * 0.025,
                  backgroundColor: AppColors.secondaryContainerColor,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              ),
              Text('$displayPercent%', style: AppTextStyle.label14Primary),
            ],
          ),
        ],
      ),
    );
  }
}