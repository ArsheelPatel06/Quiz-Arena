import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/home%20screen/widget/category_card.dart';
import 'package:quiz_app_flutter/ui/screens/tabs/home%20screen/widget/quiz_list_item.dart';
import '../../../../providers/quiz_provider.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../seed_data.dart';
import '../../../../utlis/app_colors.dart';
import '../../../../utlis/app_routes .dart';
import '../../../../utlis/app_text.dart';
import '../../../../core/services/firestore_service.dart';
import '../../../../models/result_model.dart';

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

      // Load recent results if user is logged in
      final userId = authProvider.currentUser?.id;
      final userName = authProvider.currentUser?.name;
      if (userId != null) {
        DatabaseSeeder.seedRecentActivity(userId, userName ?? 'User').then((_) {
          quizProvider.loadRecentResults(userId);
        });
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
                Text('Top Leads (Leaderboard)', style: AppTextStyle.title22OnSurface),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.leaderboardScreen, arguments: 'tech-trivia');
                  },
                  child: Text('View Full', style: AppTextStyle.label12OnSurfaceVariant.copyWith(color: AppColors.primaryColor)),
                ),
              ],
            ),
            SizedBox(height: height * 0.015),
            // We use the leaderboard UI snippet for home screen
            _buildTopLeads(context),
            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Activity', style: AppTextStyle.title22OnSurface),
              ],
            ),
            SizedBox(height: height * 0.015),
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

  Widget _buildTopLeads(BuildContext context) {
    return FutureBuilder<List<ResultModel>>(
      future: FirestoreService().getLeaderboard('tech-trivia'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Text('Failed to load leaderboard', style: TextStyle(color: Colors.red));
        }
        final leads = snapshot.data ?? [];
        if (leads.isEmpty) {
          return const Text('No top leads yet. Be the first!', style: TextStyle(color: Colors.grey));
        }

        // Show top 3
        final top3 = leads.take(3).toList();
        return Column(
          children: top3.asMap().entries.map((entry) {
            final int index = entry.key;
            final lead = entry.value;
            final int score = lead.score;
            final String name = lead.userName;
            
            // Give them a medal based on rank
            IconData medalIcon = Icons.military_tech;
            Color medalColor = Colors.grey;
            if (index == 0) medalColor = Colors.amber;
            else if (index == 1) medalColor = Colors.grey.shade400;
            else if (index == 2) medalColor = Colors.brown.shade400;

            return QuizListItem(
              title: name,
              subtitle: 'Top Lead',
              score: '$score pts',
              date: '#${index + 1}',
              icon: medalIcon,
            );
          }).toList(),
        );
      },
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
      AppColors.vibrantBlue,
      AppColors.vibrantPink,
      AppColors.vibrantGreen,
      AppColors.vibrantOrange,
      AppColors.vibrantPurple,
    ];
    final icons = [Icons.science, Icons.calculate, Icons.computer, Icons.sports_esports];

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
        gradient: AppColors.lootBoxGradient,
        borderRadius: BorderRadius.circular(width * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('LOOT BOX', style: AppTextStyle.headline28OnSurface.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                SizedBox(height: height * 0.01),
                Text(
                  quizProvider.recentResults.isEmpty
                      ? 'Complete tasks\nWin Rewards'
                      : 'Weekly Progress: $displayPercent%\nKeep it up to win!',
                  style: AppTextStyle.body14OnSurfaceVariant.copyWith(color: Colors.white70),
                ),
                SizedBox(height: height * 0.015),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.01),
                  decoration: BoxDecoration(
                    color: AppColors.goldColor,
                    borderRadius: BorderRadius.circular(width * 0.05),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Complete Now ', style: AppTextStyle.label14Primary.copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
                      const Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // A huge trophy or chest icon
          Icon(Icons.military_tech, size: width * 0.25, color: AppColors.goldColor),
        ],
      ),
    );
  }
}