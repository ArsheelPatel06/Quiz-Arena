// ── Question Model ─────────────────────────────────────────────────────────
// Represents a single quiz question stored in Firestore.
//
// Firestore document shape:
// {
//   "text": "What is 2 + 2?",
//   "options": ["1", "2", "4", "8"],
//   "correctIndex": 2          // index of the correct option in the list
// }

class QuestionModel {
  final String id;          // Firestore document ID
  final String text;        // The question text shown to the user
  final List<String> options; // The 4 answer choices
  final int correctIndex;   // Which option (0–3) is the right answer

  QuestionModel({
    required this.id,
    required this.text,
    required this.options,
    required this.correctIndex,
  });

  // ── fromMap ──────────────────────────────────────────────
  // Called when we READ a document from Firestore.
  // `map`  = the document's data fields
  // `docId` = the document's ID (we get this separately)
  factory QuestionModel.fromMap(Map<String, dynamic> map, String docId) {
    return QuestionModel(
      id: docId,
      text: map['text'] ?? '',
      // Firestore returns List<dynamic>, so we cast each item to String
      options: List<String>.from(map['options'] ?? []),
      correctIndex: map['correctIndex'] ?? 0,
    );
  }

  // ── toMap ────────────────────────────────────────────────
  // Called when we WRITE a document to Firestore.
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'options': options,
      'correctIndex': correctIndex,
    };
  }
}