import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class MyUsersProvider extends ChangeNotifier {

  // The logged-in user's data (null if not logged in)
  MyUsers? currentUser;

  // True while a login/register request is in progress
  bool isLoading = false;

  // Is this an Admin user?
  bool isAdmin = false;

  // Holds an error message to show in the UI (null = no error)
  String? errorMessage;

  // ── Setters ────────────────────────────────────────────────

  // Call this after login or register succeeds
  void updateUsers(MyUsers myUsers) {
    currentUser = myUsers;
    notifyListeners(); // rebuilds every widget listening to this provider
  }

  // Call this when the user logs out
  void clearUser() {
    currentUser = null;
    isAdmin = false;
    notifyListeners();
  }

  // Set admin state
  void setAdmin(bool value) {
    isAdmin = value;
    notifyListeners();
  }

  // Show or hide the loading spinner
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // Store an error message so the UI can show it
  void setError(String? message) {
    errorMessage = message;
    notifyListeners();
  }

  // Clear the error (call this before a new request)
  void clearError() {
    errorMessage = null;
    notifyListeners();
  }
}