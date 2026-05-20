<div align="center">

# 🧠 QuizMaster — Flutter Quiz App

**A full-featured, Firebase-powered mobile quiz application built with Flutter.**  
Challenge yourself across multiple categories, track your scores, and compete on the go — all in a sleek, responsive UI.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Firestore%20%7C%20Auth-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

</div>

---

## 📖 Table of Contents

- [About](#-about)
- [Features](#-features)
- [Demo](#-demo)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Firebase Setup](#-firebase-setup)
- [Firestore Data Model](#-firestore-data-model)
- [Contributing](#-contributing)
- [License](#-license)

---

## 📌 About

**QuizMaster** is a cross-platform mobile quiz application (Android & iOS) built entirely with Flutter and Firebase. Users can register or sign in with Google, browse quiz categories, take timed quizzes, and instantly see their results. All quiz content and user progress are stored in Cloud Firestore, providing real-time data synchronisation across sessions.

---

## ✨ Features

### 🔐 Authentication
- Email & Password registration and login via **Firebase Auth**
- **Google Sign-In** with automatic account creation in Firestore
- Persistent auth state — users stay logged in across app restarts
- Secure logout that clears both Firebase session and Google Sign-In token

### 📚 Quiz System
- Browse quizzes organised by **category** (e.g. Maths, Science, Code)
- Filter quizzes by difficulty: **Easy**, **Medium**, **Hard**
- Per-question **15-second countdown timer** with visual urgency indicator
- Progress bar showing current question position
- Answer selection with instant visual feedback
- "Next Question" flow with a final **"Finish"** prompt on the last question

### 📊 Results & Progress Tracking
- Detailed result screen showing **correct / wrong** counts and percentage
- Dynamic result message based on score (*Excellent Work!*, *Good Job!*, *Keep Practicing!*)
- Results saved automatically to **Cloud Firestore** under the user's profile
- **Recent quizzes** list on the Home screen pulled from Firestore
- **Weekly progress** circular indicator showing average score across recent results

### 👤 User Profile
- Displays real user name and email from Firebase/Firestore
- Account settings section (Edit Profile, Notifications)
- Dark Mode preference toggle (UI ready)
- One-tap **logout**

### 🎨 UI / UX
- Clean, modern design with a consistent purple-primary theme
- Fully **responsive** layout using `MediaQuery` for all screen sizes
- `SingleChildScrollView` layouts to handle smaller devices gracefully
- Smooth navigation with named routes and `pushNamedAndRemoveUntil`
- Loading dialogs and error dialogs for every async operation

---

## 🎬 Demo

<div align="center">

[![QuizMaster Demo](https://img.youtube.com/vi/R8LsBDNd8ps/maxresdefault.jpg)](https://youtu.be/R8LsBDNd8ps)

> ▶️ Click the thumbnail above to watch the full app demo on YouTube

</div>

---

## 🛠 Tech Stack

| Layer | Technology |
|-------|-----------|
| **Framework** | Flutter 3.x |
| **Language** | Dart 3.x |
| **Authentication** | Firebase Authentication (Email/Password + Google Sign-In) |
| **Database** | Cloud Firestore |
| **State Management** | Provider (`ChangeNotifier` + `MultiProvider`) |
| **Google Sign-In** | `google_sign_in` package |
| **Icons** | `icons_plus` (Clarity icon set) |
| **Architecture** | Feature-first with Service + Provider layers |
| **Platform Support** | Android, iOS |

### Key Packages

```yaml
dependencies:
  firebase_core: ...
  firebase_auth: ...
  cloud_firestore: ...
  google_sign_in: ...
  provider: ...
  icons_plus: ...
```

---

## 🏗 Architecture

The app follows a clean **3-layer architecture**:

```
UI (Screens & Widgets)
        ↕  reads/writes via
Providers (QuizProvider, MyUsersProvider)
        ↕  delegates data access to
Services (FirestoreService, AuthService)
        ↕  communicates with
Firebase (Auth + Firestore)
```

- **Screens** never talk to Firebase directly — they only consume Providers.
- **Providers** hold state and call Services for async operations, then call `notifyListeners()`.
- **Services** are stateless classes that wrap Firebase SDK calls.
- **Models** (`MyUsers`, `QuestionModel`, `ResultModel`) handle serialisation to/from Firestore.

---

## 📁 Project Structure

```
lib/
├── core/
│   └── services/
│       ├── auth_service.dart          # Firebase Auth wrapper (login, register, logout)
│       └── firestore_service.dart     # All Firestore read/write operations
│
├── models/
│   ├── user_model.dart                # MyUsers data class + Firestore serialisation
│   ├── question_model.dart            # QuestionModel with fromMap / toMap
│   └── result_model.dart              # ResultModel with fromMap / toMap
│
├── providers/
│   ├── auth_provider.dart             # MyUsersProvider — current user state
│   └── quiz_provider.dart             # QuizProvider — categories, quizzes, quiz logic, results
│
├── ui/
│   └── screens/
│       ├── auth/
│       │   ├── login_screen.dart      # Email login + Google Sign-In
│       │   └── register_screen.dart   # New account creation
│       ├── tabs/
│       │   ├── home screen/
│       │   │   └── home_screen.dart   # Categories, recent results, progress card
│       │   ├── quiz screen/
│       │   │   ├── quizzes_screen.dart      # Quiz list with difficulty filter chips
│       │   │   ├── quiz_focus_screen.dart   # Active quiz with timer & answer selection
│       │   │   └── quiz_result_screen.dart  # Score display + save to Firestore
│       │   └── profile screen/
│       │       └── profile_screen.dart      # User info + logout
│       └── nav_bar_screen.dart        # Bottom navigation wrapper
│
├── utils/
│   ├── app_colors.dart                # Centralised colour palette
│   ├── app_text.dart                  # Typography styles
│   ├── app_assets.dart                # Asset path constants
│   ├── app_routes.dart                # Named route constants
│   └── dialog_utils.dart              # Loading & message dialog helpers
│
├── widgets/
│   ├── custom_text_form_field.dart    # Reusable text input with validation
│   └── custom_elevated_button.dart   # Reusable primary action button
│
├── firebase_utils.dart                # Firestore User collection helpers
├── firebase_options.dart              # Auto-generated by FlutterFire CLI
└── main.dart                          # App entry point, Firebase init, MultiProvider setup
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) **3.0+**
- [Dart SDK](https://dart.dev/get-dart) **3.0+**
- A [Firebase project](https://console.firebase.google.com/) with **Authentication** and **Firestore** enabled
- Android Studio / VS Code with the Flutter & Dart plugins

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/quiz-master-flutter.git
cd quiz-master-flutter
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

Follow the [Firebase Setup](#-firebase-setup) section below, then run:

```bash
flutterfire configure
```

This regenerates `firebase_options.dart` for your own Firebase project.

### 4. Run the App

```bash
# Debug mode
flutter run

# Release mode (Android)
flutter run --release

# Specific device
flutter run -d <device-id>
```

---

## 🔥 Firebase Setup

### Step 1 — Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/) and create a new project.
2. Add **Android** and/or **iOS** apps to your project.
3. Download the config files:
   - Android: `google-services.json` → place in `android/app/`
   - iOS: `GoogleService-Info.plist` → place in `ios/Runner/`

### Step 2 — Enable Authentication

In the Firebase Console:
- Go to **Authentication → Sign-in method**
- Enable **Email/Password**
- Enable **Google**

### Step 3 — Enable Cloud Firestore

- Go to **Firestore Database → Create database**
- Start in **production mode** (or test mode for development)
- Apply the following security rules for development:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /Users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /categories/{categoryId} {
      allow read: if request.auth != null;
      match /quizzes/{quizId} {
        allow read: if request.auth != null;
        match /questions/{questionId} {
          allow read: if request.auth != null;
        }
      }
    }
    match /users/{userId}/results/{resultId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### Step 4 — Enable Google Sign-In (Android)

Add your SHA-1 fingerprint to the Firebase project:

```bash
# Get debug SHA-1
cd android
./gradlew signingReport
```

Copy the `SHA1` value from the output and add it in:  
Firebase Console → Project Settings → Your Android App → **Add Fingerprint**

---

## 🗄 Firestore Data Model

```
Firestore Root
│
├── Users/                          ← top-level collection
│   └── {userId}/                   ← document per user
│       ├── id: string
│       ├── name: string
│       └── email: string
│
├── categories/                     ← top-level collection
│   └── {categoryId}/               ← document per category
│       ├── name: string
│       ├── icon: string (optional)
│       └── quizzes/                ← sub-collection
│           └── {quizId}/
│               ├── title: string
│               ├── description: string
│               ├── difficulty: "Easy" | "Medium" | "Hard"
│               ├── duration: string
│               └── questions/      ← sub-collection
│                   └── {questionId}/
│                       ├── text: string
│                       ├── options: string[]   (4 items)
│                       └── correctIndex: number (0–3)
│
└── users/                          ← results collection (separate from Users)
    └── {userId}/
        └── results/
            └── {resultId}/
                ├── userId: string
                ├── quizId: string
                ├── score: number
                ├── totalQuestions: number
                ├── percentage: number
                └── date: Timestamp
```

---

## 🤝 Contributing

Contributions are welcome! Here's how to get started:

1. **Fork** the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'feat: add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a **Pull Request**

Please follow the existing code style and add comments for any non-trivial logic.

### Planned Features / Good First Issues

- [ ] Review Answers screen after quiz completion
- [ ] Store quiz title in `ResultModel` for better history display
- [ ] Edit Profile screen
- [ ] Dark Mode implementation
- [ ] Push notifications for daily quiz reminders
- [ ] Leaderboard screen using shared Firestore results
- [ ] Localization / Arabic language support

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

Made with ❤️ using Flutter & Firebase

⭐ If you found this project useful, please consider giving it a star!

</div>
