// import 'package:flutter/foundation.dart';
//
// import '../core/services/firestore_service.dart';
// import '../models/question_model.dart';
// import '../models/result_model.dart';
//
// // ── QuizProvider ──────────────────────────────────────────────────────────
// // This is the brain of the app.
// // It holds ALL the data the UI needs and ALL the quiz logic.
// //
// // How Provider works (simple explanation):
// //   1. QuizProvider extends ChangeNotifier
// //   2. When data changes, we call notifyListeners()
// //   3. The UI rebuilds automatically wherever it listens to this provider
//
// class QuizProvider extends ChangeNotifier {
//   // ── Service ───────────────────────────────────────────────
//   // We use FirestoreService to fetch data — provider doesn't talk to DB directly
//   final FirestoreService _firestoreService = FirestoreService();
//
//   // =========================================================
//   // SECTION 1 — DATA STORAGE
//   // These lists hold the data loaded from Firestore
//   // =========================================================
//
//   // List of category maps. Each map has: id, name, icon, color, etc.
//   List<Map<String, dynamic>> categories = [];
//
//   List<ResultModel> recentResults = [];
//
//   // List of quiz maps for the selected category. Each map has: id, title, etc.
//   List<Map<String, dynamic>> quizzes = [];
//
//   // List of QuestionModel objects for the active quiz
//   List<QuestionModel> questions = [];
//
//   // ── Loading state ─────────────────────────────────────────
//   // true while we are waiting for Firestore to respond
//   bool isLoading = false;
//
//   // ── Error message ─────────────────────────────────────────
//   // Stores the last error message so the UI can show it
//   String? errorMessage;
//
//   // =========================================================
//   // SECTION 2 — ACTIVE QUIZ STATE
//   // These track where the user is in the quiz right now
//   // =========================================================
//
//   // Which question is currently showing (0-based index)
//   int currentQuestionIndex = 0;
//
//   // Stores the user's chosen answer for each question.
//   // Key   = question index (0, 1, 2 ...)
//   // Value = the option index the user picked (0–3), or -1 if skipped
//   Map<int, int> selectedAnswers = {};
//
//   // The ID of the category the user chose
//   String selectedCategoryId = '';
//
//   // The ID of the quiz the user chose
//   String selectedQuizId = '';
//
//   // =========================================================
//   // SECTION 3 — LOADING DATA FROM FIRESTORE
//   // =========================================================
//
//   // ── loadCategories ────────────────────────────────────────
//   // Fetches all categories and stores them in `categories`.
//   // Call this when the home screen opens.
//   Future<void> loadCategories() async {
//     _setLoading(true); // show spinner
//
//     try {
//       categories = await _firestoreService.getCategories();
//       errorMessage = null;
//     } catch (e) {
//       // If something goes wrong, save the error so the UI can show it
//       errorMessage = 'Failed to load categories: $e';
//     }
//
//     _setLoading(false); // hide spinner
//   }
//
//   // ── loadQuizzes ───────────────────────────────────────────
//   // Fetches quizzes for the chosen category.
//   // Call this when the user taps a category card.
//   Future<void> loadQuizzes(String categoryId) async {
//     _setLoading(true);
//     selectedCategoryId = categoryId; // remember which category was picked
//
//     try {
//       quizzes = await _firestoreService.getQuizzesByCategory(categoryId);
//       errorMessage = null;
//     } catch (e) {
//       errorMessage = 'Failed to load quizzes: $e';
//     }
//
//     _setLoading(false);
//   }
//
//   // ── loadQuestions ─────────────────────────────────────────
//   // Fetches questions for the chosen quiz.
//   // Call this when the user taps a quiz card.
//   Future<void> loadQuestions(String quizId) async {
//     _setLoading(true);
//     selectedQuizId = quizId; // remember which quiz was picked
//
//     try {
//       questions = await _firestoreService.getQuestionsByQuiz(
//         selectedCategoryId,
//         quizId,
//       );
//       errorMessage = null;
//     } catch (e) {
//       errorMessage = 'Failed to load questions: $e';
//     }
//
//     _setLoading(false);
//   }
//
//   // =========================================================
//   // SECTION 4 — QUIZ LOGIC
//   // =========================================================
//
//   // ── selectAnswer ─────────────────────────────────────────
//   // Called when the user taps an answer option.
//   // `questionIndex` = which question (e.g. 0, 1, 2...)
//   // `answerIndex`   = which option they tapped (0–3)
//   void selectAnswer(int questionIndex, int answerIndex) {
//     selectedAnswers[questionIndex] = answerIndex;
//     notifyListeners(); // tell the UI to rebuild (highlight the chosen answer)
//   }
//
//   // ── nextQuestion ─────────────────────────────────────────
//   // Moves to the next question.
//   // Returns true  → moved to next question
//   // Returns false → already at the last question (quiz is over)
//   bool nextQuestion() {
//     // Check if there is a next question
//     if (currentQuestionIndex < questions.length - 1) {
//       currentQuestionIndex++;
//       notifyListeners();
//       return true; // successfully moved forward
//     }
//     return false; // we were on the last question
//   }
//
//   // ── resetQuiz ────────────────────────────────────────────
// // Clears quiz progress. Pass clearQuestions: true when going home.
//   void resetQuiz({bool clearQuestions = false}) {
//     currentQuestionIndex = 0;
//     selectedAnswers = {};
//     if (clearQuestions) {
//       questions = [];
//     }
//     notifyListeners();
//   }
//
//   // ── isLastQuestion ───────────────────────────────────────
//   // Helper: returns true if the user is on the final question.
//   // The UI can use this to show "Finish" instead of "Next".
//   bool get isLastQuestion {
//     return currentQuestionIndex == questions.length - 1;
//   }
//
//   // ── currentQuestion ──────────────────────────────────────
//   // Helper: returns the QuestionModel for the current screen.
//   QuestionModel? get currentQuestion {
//     if (questions.isEmpty) return null;
//     return questions[currentQuestionIndex];
//   }
//
//   // =========================================================
//   // SECTION 5 — RESULT LOGIC
//   // =========================================================
//
//   // ── calculateScore ───────────────────────────────────────
//   // Counts how many answers the user got correct.
//   // It compares selectedAnswers[i] with questions[i].correctIndex
//   int calculateScore() {
//     int score = 0;
//
//     for (int i = 0; i < questions.length; i++) {
//       // Did the user answer this question?
//       if (selectedAnswers.containsKey(i)) {
//         // Is their answer the correct one?
//         if (selectedAnswers[i] == questions[i].correctIndex) {
//           score++;
//         }
//       }
//     }
//
//     return score;
//   }
//
//   // ── calculatePercentage ──────────────────────────────────
//   // Converts the score into a percentage (0.0 to 100.0).
//   // Example: 7 correct out of 10 → 70.0
//   double calculatePercentage() {
//     // Guard: avoid dividing by zero if questions list is empty
//     if (questions.isEmpty) return 0.0;
//
//     int score = calculateScore();
//     return (score / questions.length) * 100;
//   }
//
//   // ── saveResult ───────────────────────────────────────────
//   // Creates a ResultModel from the current quiz and saves it to Firestore.
//   // `userId` = the Firebase Auth UID of the logged-in user
//   Future<void> saveResult(String userId) async {
//     final result = ResultModel(
//       id: '',                              // Firestore will auto-generate this
//       userId: userId,
//       quizId: selectedQuizId,
//       score: calculateScore(),
//       totalQuestions: questions.length,
//       percentage: calculatePercentage(),
//       date: DateTime.now(),
//     );
//
//     try {
//       await _firestoreService.saveResult(result);
//     } catch (e) {
//       errorMessage = 'Failed to save result: $e';
//       notifyListeners();
//     }
//   }
//   // ── loadRecentResults ─────────────────────────────────────
// // Loads the user's last 5 quiz results for the home screen.
//   Future<void> loadRecentResults(String userId) async {
//     try {
//       recentResults = await _firestoreService.getRecentResults(userId);
//       notifyListeners();
//     } catch (e) {
//       errorMessage = 'Failed to load results: $e';
//       notifyListeners();
//     }
//   }
//
//
//
//   // =========================================================
//   // PRIVATE HELPERS
//   // =========================================================
//
//   // ── _setLoading ───────────────────────────────────────────
//   // Simple helper to flip the loading flag and notify the UI.
//   void _setLoading(bool value) {
//     isLoading = value;
//     notifyListeners();
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../core/services/firestore_service.dart';
import '../models/question_model.dart';
import '../models/result_model.dart';

class QuizProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  // ── Data ──────────────────────────────────────────────────
  List<Map<String, dynamic>> categories = [];
  List<ResultModel> recentResults = [];
  List<Map<String, dynamic>> quizzes = [];
  List<QuestionModel> questions = [];

  bool isLoading = false;
  String? errorMessage;

  // ── Active Quiz State ─────────────────────────────────────
  int currentQuestionIndex = 0;
  Map<int, int> selectedAnswers = {};
  String selectedCategoryId = '';
  String selectedQuizId = '';

  // ── loadCategories ────────────────────────────────────────
  Future<void> loadCategories() async {
    _setLoading(true);

    try {
      categories = await _firestoreService.getCategories();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to load categories: $e';
    }

    _setLoading(false);
  }

  // ── loadQuizzes ───────────────────────────────────────────
  // If categoryId is empty, loads ALL quizzes across every category.
  // If categoryId is provided, loads only that category's quizzes.
  Future<void> loadQuizzes(String categoryId) async {
    _setLoading(true);
    selectedCategoryId = categoryId;

    try {
      if (categoryId.isEmpty) {
        // NEW: no category selected → fetch all quizzes from every category
        quizzes = await _firestoreService.getAllQuizzes();
      } else {
        quizzes = await _firestoreService.getQuizzesByCategory(categoryId);
      }
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to load quizzes: $e';
    }

    _setLoading(false);
  }

  // ── loadQuestions ─────────────────────────────────────────
  // CHANGED: now accepts an optional categoryId override.
  // This is needed when loading a quiz from the "all quizzes" list,
  // where each quiz carries its own categoryId in the map.
  Future<void> loadQuestions(String quizId, {String? categoryId}) async {
    _setLoading(true);
    selectedQuizId = quizId;

    // Use the override if provided, otherwise fall back to selectedCategoryId
    final effectiveCategoryId = categoryId ?? selectedCategoryId;
    selectedCategoryId = effectiveCategoryId;

    try {
      questions = await _firestoreService.getQuestionsByQuiz(
        effectiveCategoryId,
        quizId,
      );
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to load questions: $e';
    }

    _setLoading(false);
  }

  // ── selectAnswer ──────────────────────────────────────────
  void selectAnswer(int questionIndex, int answerIndex) {
    selectedAnswers[questionIndex] = answerIndex;
    notifyListeners();
  }

  // ── nextQuestion ──────────────────────────────────────────
  bool nextQuestion() {
    // ASSIGNMENT DEMO - Question progression
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
      notifyListeners();
      return true; // corresponds to startTimer() in UI
    } else {
      return false; // corresponds to finishQuiz() in UI
    }
  }

  // ── resetQuiz ─────────────────────────────────────────────
  void resetQuiz({bool clearQuestions = false}) {
    currentQuestionIndex = 0;
    selectedAnswers = {};
    if (clearQuestions) {
      questions = [];
    }
    notifyListeners();
  }

  // ── Helpers ───────────────────────────────────────────────
  bool get isLastQuestion => currentQuestionIndex == questions.length - 1;

  QuestionModel? get currentQuestion {
    if (questions.isEmpty) return null;
    return questions[currentQuestionIndex];
  }

  // ── Score / Result ────────────────────────────────────────
  int calculateScore() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers.containsKey(i)) {
        // ASSIGNMENT DEMO - Correct answer
        int selectedIndex = selectedAnswers[i]!;
        if (selectedIndex == questions[i].correctIndex) {
          score++;
        }
      }
    }
    return score;
  }

  double calculatePercentage() {
    if (questions.isEmpty) return 0.0;
    return (calculateScore() / questions.length) * 100;
  }

  Future<void> saveResult(String userId) async {
    final auth = FirebaseAuth.instance;
    final userName = auth.currentUser?.displayName ?? auth.currentUser?.email ?? 'Anonymous';

    final List<Map<String, dynamic>> details = [];
    for (int i = 0; i < questions.length; i++) {
      int? selectedIndex = selectedAnswers[i];
      details.add({
        'question': questions[i].text,
        'selected': selectedIndex != null ? questions[i].options[selectedIndex] : 'No Answer',
        'correct': questions[i].options[questions[i].correctIndex],
        'isCorrect': selectedIndex == questions[i].correctIndex,
      });
    }

    final result = ResultModel(
      id: '',
      userId: userId,
      userName: userName,
      quizId: selectedQuizId,
      score: calculateScore(),
      totalQuestions: questions.length,
      percentage: calculatePercentage(),
      date: DateTime.now(),
      detailedResponses: details,
    );

    try {
      await _firestoreService.saveResult(result);
    } catch (e) {
      errorMessage = 'Failed to save result: $e';
      notifyListeners();
    }
  }

  Future<void> loadRecentResults(String userId) async {
    try {
      recentResults = await _firestoreService.getRecentResults(userId);
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to load results: $e';
      notifyListeners();
    }
  }

  // ── Private ───────────────────────────────────────────────
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}