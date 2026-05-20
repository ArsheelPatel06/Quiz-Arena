// ── Result Model ──────────────────────────────────────────────────────────
// Represents a quiz result that we save to Firestore after the user finishes.
//
// Firestore document shape (inside users/{uid}/results/{resultId}):
// {
//   "userId": "abc123",
//   "quizId": "quiz_xyz",
//   "score": 7,
//   "totalQuestions": 10,
//   "percentage": 70.0,
//   "date": Timestamp
// }

class ResultModel {
  final String id;             // Firestore document ID (empty when creating)
  final String userId;         // Firebase Auth UID of the user
  final String quizId;         // Which quiz was taken
  final int score;             // How many answers were correct
  final int totalQuestions;    // Total number of questions in the quiz
  final double percentage;     // score / totalQuestions * 100
  final DateTime date;         // When the quiz was completed

  ResultModel({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.score,
    required this.totalQuestions,
    required this.percentage,
    required this.date,
  });

  // ── fromMap ──────────────────────────────────────────────
  // Called when we READ a result document from Firestore.
  factory ResultModel.fromMap(Map<String, dynamic> map, String docId) {
    return ResultModel(
      id: docId,
      userId: map['userId'] ?? '',
      quizId: map['quizId'] ?? '',
      score: map['score'] ?? 0,
      totalQuestions: map['totalQuestions'] ?? 0,
      percentage: (map['percentage'] ?? 0.0).toDouble(),
      // Firestore stores dates as Timestamp; .toDate() converts to DateTime
      date: (map['date'] as dynamic)?.toDate() ?? DateTime.now(),
    );
  }

  // ── toMap ────────────────────────────────────────────────
  // Called when we WRITE a result to Firestore.
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'quizId': quizId,
      'score': score,
      'totalQuestions': totalQuestions,
      'percentage': percentage,
      'date': date,
    };
  }
}