import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/firestore_service.dart';
import '../../models/result_model.dart';
import '../../providers/quiz_provider.dart';
import '../../utlis/app_colors.dart';
import '../../utlis/app_text.dart';

class LeaderboardScreen extends StatefulWidget {
  final String quizId;

  const LeaderboardScreen({Key? key, required this.quizId}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  bool _isLoading = true;
  List<ResultModel> _leaderboard = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchLeaderboard();
  }

  Future<void> _fetchLeaderboard() async {
    try {
      final results = await _firestoreService.getLeaderboard(widget.quizId);
      setState(() {
        _leaderboard = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load leaderboard: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Leaderboard', style: AppTextStyle.medium22Black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _leaderboard.isEmpty
                  ? const Center(child: Text('No scores yet for this contest!'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _leaderboard.length,
                      itemBuilder: (context, index) {
                        final result = _leaderboard[index];
                        final isCurrentUser = result.userId == currentUserId;

                        return Card(
                          color: isCurrentUser ? AppColors.primaryColor.withOpacity(0.1) : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: isCurrentUser
                                ? BorderSide(color: AppColors.primaryColor, width: 2)
                                : BorderSide.none,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: index == 0 ? Colors.amber : index == 1 ? Colors.grey[400] : index == 2 ? Colors.brown[300] : AppColors.primaryColor,
                              child: index < 3 ? const Icon(Icons.emoji_events, color: Colors.white, size: 20) : Text(
                                '#${index + 1}',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(
                              result.userName,
                              style: isCurrentUser
                                  ? AppTextStyle.medium16Black.copyWith(fontWeight: FontWeight.bold)
                                  : AppTextStyle.medium16Black,
                            ),
                            subtitle: Text('Score: ${result.score} / ${result.totalQuestions}'),
                            trailing: Text(
                              '${result.percentage.toStringAsFixed(1)}%',
                              style: AppTextStyle.medium16Black.copyWith(color: AppColors.primaryColor),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
