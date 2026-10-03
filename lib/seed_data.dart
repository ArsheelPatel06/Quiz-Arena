import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseSeeder {
  static Future<void> seedTechTrivia() async {
    final db = FirebaseFirestore.instance;

    // --- SCIENCE CATEGORY (Biology) ---
    await db.collection('categories').doc('science').set({
      'name': 'Science',
      'icon': 'Science',
      'color': '0xFF6750A4', // Use theme color
    });

    await db.collection('categories').doc('science').collection('quizzes').doc('biology-101').set({
      'title': 'Biology 101',
      'description': 'Test your biology knowledge',
      'difficulty': 'Medium',
      'duration': '15sec',
      'category': 'Science',
    });

    final bioQuestions = [
      {"text": "What is the powerhouse of the cell?", "options": ["Nucleus", "Ribosome", "Mitochondria", "Golgi"], "correctIndex": 2},
      {"text": "What is the basic unit of life?", "options": ["Cell", "Tissue", "Organ", "System"], "correctIndex": 0},
      {"text": "Which gas do plants absorb from the atmosphere?", "options": ["Oxygen", "Carbon Dioxide", "Nitrogen", "Hydrogen"], "correctIndex": 1},
      {"text": "How many bones are in the adult human body?", "options": ["206", "208", "210", "212"], "correctIndex": 0},
      {"text": "What pigment gives leaves their green color?", "options": ["Carotene", "Melanin", "Chlorophyll", "Hemoglobin"], "correctIndex": 2},
    ];

    final bioRef = db.collection('categories').doc('science').collection('quizzes').doc('biology-101').collection('questions');
    final bioDocs = await bioRef.get();
    for (var doc in bioDocs.docs) await doc.reference.delete();
    for (var q in bioQuestions) await bioRef.add(q);

    // --- MATH CATEGORY (Algebra) ---
    await db.collection('categories').doc('math').set({
      'name': 'Math',
      'icon': 'Calculate',
      'color': '0xFF1976D2',
    });

    await db.collection('categories').doc('math').collection('quizzes').doc('algebra-basics').set({
      'title': 'Algebra Basics',
      'description': 'Test your algebra knowledge',
      'difficulty': 'Easy',
      'duration': '10 mins',
      'category': 'Math',
    });

    final mathQuestions = [
      {"text": "If x = 2, what is x + 3?", "options": ["4", "5", "6", "7"], "correctIndex": 1},
      {"text": "Solve for y: 2y = 10", "options": ["3", "4", "5", "6"], "correctIndex": 2},
      {"text": "What is the value of 5 squared?", "options": ["10", "15", "20", "25"], "correctIndex": 3},
      {"text": "If 3x = 12, what is x?", "options": ["2", "3", "4", "5"], "correctIndex": 2},
      {"text": "Simplify: 2(x + 4)", "options": ["2x + 4", "2x + 8", "x + 8", "2x + 2"], "correctIndex": 1},
    ];

    final mathRef = db.collection('categories').doc('math').collection('quizzes').doc('algebra-basics').collection('questions');
    final mathDocs = await mathRef.get();
    for (var doc in mathDocs.docs) await doc.reference.delete();
    for (var q in mathQuestions) await mathRef.add(q);
    
    // --- CODE CATEGORY (Computer) ---
    await db.collection('categories').doc('code').set({
      'name': 'Code',
      'icon': 'Computer',
      'color': '0xFF388E3C',
    });

    await db.collection('categories').doc('code').collection('quizzes').doc('computer-basics').set({
      'title': 'Computer Basics',
      'description': 'Test your computer knowledge',
      'difficulty': 'Hard',
      'duration': '15 mins',
      'category': 'Code',
    });

    final codeQuestions = [
      {"text": "What does CPU stand for?", "options": ["Central Process Unit", "Computer Personal Unit", "Central Processing Unit", "Central Processor Unit"], "correctIndex": 2},
      {"text": "Which of these is a programming language?", "options": ["HTML", "Python", "HTTP", "FTP"], "correctIndex": 1},
      {"text": "What does RAM stand for?", "options": ["Random Access Memory", "Read Access Memory", "Run All Memory", "Read All Memory"], "correctIndex": 0},
      {"text": "Which company created Flutter?", "options": ["Apple", "Microsoft", "Google", "Facebook"], "correctIndex": 2},
      {"text": "What symbol is used for comments in Dart?", "options": ["//", "#", "<!--", "/*"], "correctIndex": 0},
    ];

    final codeRef = db.collection('categories').doc('code').collection('quizzes').doc('computer-basics').collection('questions');
    final codeDocs = await codeRef.get();
    for (var doc in codeDocs.docs) await doc.reference.delete();
    for (var q in codeQuestions) await codeRef.add(q);

    // --- FAKE LEADERBOARD FOR TECH TRIVIA ---
    final mockLeaderboard = [
      {"userId": "user1", "name": "Aarav Sharma", "score": 90},
      {"userId": "user2", "name": "Priya Patel", "score": 85},
      {"userId": "user3", "name": "Rohan Gupta", "score": 75},
      {"userId": "user4", "name": "Ananya Desai", "score": 60},
    ];

    for (var result in mockLeaderboard) {
      await db.collection('leaderboards').doc('tech-trivia').collection('entries').doc(result['userId'] as String).set(result);
    }

    print("✅ Seeded Biology, Algebra, and Computer quizzes, and fake leaderboard!");
  }

  static Future<void> seedRecentActivity(String userId, String userName) async {
    final db = FirebaseFirestore.instance;
    final resultsRef = db.collection('users').doc(userId).collection('results');
    
    // Check if user already has results
    final snapshot = await resultsRef.get();
    if (snapshot.docs.isNotEmpty) return; // Already seeded

    final fakeResults = [
      {"userId": userId, "userName": userName, "quizId": "biology-101", "score": 2, "totalQuestions": 2, "percentage": 100.0, "date": DateTime.now().subtract(const Duration(hours: 2))},
      {"userId": userId, "userName": userName, "quizId": "algebra-basics", "score": 1, "totalQuestions": 2, "percentage": 50.0, "date": DateTime.now().subtract(const Duration(days: 1))},
      {"userId": userId, "userName": userName, "quizId": "tech-trivia", "score": 8, "totalQuestions": 10, "percentage": 80.0, "date": DateTime.now().subtract(const Duration(days: 2))},
    ];

    for (var result in fakeResults) {
      await resultsRef.add(result);
    }
    
    print("✅ Seeded Recent Activity for user $userId!");
  }
}
