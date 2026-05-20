// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../models/question_model.dart';
// import '../../models/result_model.dart';
//
// // ── FirestoreService ──────────────────────────────────────────────────────
// // Handles ALL reading and writing to Firestore.
// // The UI and Provider never talk to Firestore directly — they go through here.
// //
// // Firestore structure assumed:
// //   categories/          (collection)
// //     {categoryId}/      (document)
// //       name, icon, color, ...
// //       quizzes/         (sub-collection)
// //         {quizId}/      (document)
// //           title, ...
// //           questions/   (sub-collection)
// //             {questionId}/
// //               text, options, correctIndex
// //
// //   users/{uid}/results/ (sub-collection for saved results)
//
// class FirestoreService {
//   // One Firestore instance for the whole app
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   // ── 1. getCategories ──────────────────────────────────────
//   // Returns a list of category maps from the 'categories' collection.
//   // Each map has the document ID added as 'id' so the UI can use it.
//   Future<List<Map<String, dynamic>>> getCategories() async {
//     // Get all documents in the 'categories' collection
//     final snapshot = await _db.collection('categories').get();
//
//     // Convert each document to a plain Map and add its ID
//     final categories = snapshot.docs.map((doc) {
//       final data = doc.data();
//       data['id'] = doc.id; // attach the document ID
//       return data;
//     }).toList();
//
//     return categories;
//   }
//
//   // ── 2. getQuizzesByCategory ───────────────────────────────
//   // Returns all quizzes inside a specific category.
//   // `categoryId` = the document ID of the category.
//   Future<List<Map<String, dynamic>>> getQuizzesByCategory(
//       String categoryId) async {
//     final snapshot = await _db
//         .collection('categories')
//         .doc(categoryId)
//         .collection('quizzes')
//         .get();
//
//     final quizzes = snapshot.docs.map((doc) {
//       final data = doc.data();
//       data['id'] = doc.id;
//       return data;
//     }).toList();
//
//     return quizzes;
//   }
//
//   // ── 3. getQuestionsByQuiz ─────────────────────────────────
//   // Returns a list of QuestionModel objects for a given quiz.
//   // `categoryId` = parent category ID
//   // `quizId`     = the quiz document ID
//   Future<List<QuestionModel>> getQuestionsByQuiz(
//       String categoryId, String quizId) async {
//     final snapshot = await _db
//         .collection('categories')
//         .doc(categoryId)
//         .collection('quizzes')
//         .doc(quizId)
//         .collection('questions')
//         .get();
//
//     // Convert each Firestore document to a QuestionModel
//     final questions = snapshot.docs.map((doc) {
//       return QuestionModel.fromMap(doc.data(), doc.id);
//     }).toList();
//
//     return questions;
//   }
//
//   // ── 4. saveResult ─────────────────────────────────────────
//   // Saves a ResultModel to Firestore under the user's results sub-collection.
//   // Path: users/{userId}/results/{auto-generated-id}
//   Future<void> saveResult(ResultModel result) async {
//     await _db
//         .collection('users')
//         .doc(result.userId)
//         .collection('results')
//         .add(result.toMap()); // .add() auto-generates the document ID
//   }
//   // ── 5. getRecentResults ───────────────────────────────────
// // Returns the last 5 quiz results for a user, newest first.
//   Future<List<ResultModel>> getRecentResults(String userId) async {
//     final snapshot = await _db
//         .collection('users')
//         .doc(userId)
//         .collection('results')
//         .orderBy('date', descending: true)
//         .limit(5)
//         .get();
//
//     return snapshot.docs.map((doc) {
//       return ResultModel.fromMap(doc.data(), doc.id);
//     }).toList();
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/question_model.dart';
import '../../models/result_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ── 1. getCategories ──────────────────────────────────────
  Future<List<Map<String, dynamic>>> getCategories() async {
    final snapshot = await _db.collection('categories').get();

    final categories = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();

    return categories;
  }

  // ── 2. getQuizzesByCategory ───────────────────────────────
  Future<List<Map<String, dynamic>>> getQuizzesByCategory(
      String categoryId) async {
    final snapshot = await _db
        .collection('categories')
        .doc(categoryId)
        .collection('quizzes')
        .get();

    final quizzes = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();

    return quizzes;
  }

  // ── 3. getAllQuizzes ───────────────────────────────────────
  // NEW: Fetches all quizzes across every category.
  // Used by the Quizzes tab when no specific category is selected.
  // Each quiz map also carries 'categoryId' so questions can be loaded later.
  Future<List<Map<String, dynamic>>> getAllQuizzes() async {
    final categoriesSnapshot = await _db.collection('categories').get();

    final List<Map<String, dynamic>> allQuizzes = [];

    for (final categoryDoc in categoriesSnapshot.docs) {
      final quizzesSnapshot = await _db
          .collection('categories')
          .doc(categoryDoc.id)
          .collection('quizzes')
          .get();

      for (final quizDoc in quizzesSnapshot.docs) {
        final data = quizDoc.data();
        data['id'] = quizDoc.id;
        // Attach the parent categoryId so we can load questions later
        data['categoryId'] = categoryDoc.id;
        allQuizzes.add(data);
      }
    }

    return allQuizzes;
  }

  // ── 4. getQuestionsByQuiz ─────────────────────────────────
  Future<List<QuestionModel>> getQuestionsByQuiz(
      String categoryId, String quizId) async {
    final snapshot = await _db
        .collection('categories')
        .doc(categoryId)
        .collection('quizzes')
        .doc(quizId)
        .collection('questions')
        .get();

    final questions = snapshot.docs.map((doc) {
      return QuestionModel.fromMap(doc.data(), doc.id);
    }).toList();

    return questions;
  }

  // ── 5. saveResult ─────────────────────────────────────────
  Future<void> saveResult(ResultModel result) async {
    await _db
        .collection('users')
        .doc(result.userId)
        .collection('results')
        .add(result.toMap());
  }

  // ── 6. getRecentResults ───────────────────────────────────
  Future<List<ResultModel>> getRecentResults(String userId) async {
    final snapshot = await _db
        .collection('users')
        .doc(userId)
        .collection('results')
        .orderBy('date', descending: true)
        .limit(5)
        .get();

    return snapshot.docs.map((doc) {
      return ResultModel.fromMap(doc.data(), doc.id);
    }).toList();
  }
}