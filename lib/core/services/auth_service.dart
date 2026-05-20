import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  // Firebase Auth instance — one instance for the whole app
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ── Register ───────────────────────────────────────────────
  // Creates a new Firebase Auth user with email + password
  // Returns UserCredential so the caller can get the uid
  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // ── Login ──────────────────────────────────────────────────
  // Signs in an existing user
  // Throws FirebaseAuthException if credentials are wrong
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // ── Logout ─────────────────────────────────────────────────
  Future<void> logout() async {
    await _auth.signOut();
  }

  // ── Current User ───────────────────────────────────────────
  // Returns the currently signed-in Firebase user, or null
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // ── Auth State Stream ──────────────────────────────────────
  // Useful for auto-login: fires every time auth state changes
  // (user signs in, signs out, token refreshes, etc.)
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}