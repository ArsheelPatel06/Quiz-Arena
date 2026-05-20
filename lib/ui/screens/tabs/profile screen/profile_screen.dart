import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';                        // NEW
import '../../../../providers/auth_provider.dart';             // NEW
import '../../../../core/services/auth_service.dart';          // NEW
import '../../../../utlis/app_colors.dart';
import '../../../../utlis/app_routes .dart';                   // NEW
import '../../../../utlis/app_text.dart';

// CHANGED: StatelessWidget → StatefulWidget
// Reason: we need to call logout() which is async
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // AuthService handles the actual Firebase logout call
  final AuthService _authService = AuthService();

  void _onLogoutTapped() async {
    // listen: false — we are calling a method, not reading UI data
    var authProvider = Provider.of<MyUsersProvider>(context, listen: false);

// Properly sign out from both Firebase and Google
    await FirebaseAuth.instance.signOut();
     await GoogleSignIn().disconnect();
    try {
      // Step 1: sign out from Firebase
      await _authService.logout();

      // Step 2: clear the user from the provider
      authProvider.clearUser();

      // Step 3: go to login screen and remove all previous screens
      // so the user can't press back and return to the app
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.loginScreen,
            (route) => false,
      );
    } catch (e) {
      // If logout fails, show a simple message
      authProvider.setError('Logout failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    // listen: true → UI rebuilds if user data changes
    var authProvider = Provider.of<MyUsersProvider>(context);

    // Read current user — may be null if not logged in
    final user = authProvider.currentUser;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05),
              // Header Section
              Container(
                padding: EdgeInsets.all(width * 0.06),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainerColor,
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: width * 0.12,
                          backgroundColor: AppColors.whiteColor,
                          // Kept as-is — no profile photo feature yet
                          backgroundImage: const NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBIXICteccs35yYP2teEu6_UpG_IpGDS-kgD7df1w7lbO4XvebSpc25Ky7SYa6iRjtL__yylT6cam2FI_1v0xVPq7iTdWc-0tc0a-5wPhAayTyFN-HfPuz2eYOlXptJOFcZ6Tkw6RkbTLCmPBkEKKKzYEtNFIHA-pZiWh32lKB_lygyogYRNyDO1za0oDUHmNEEovjnsvcSZiQr4SclS8i-IuJIeP5orz4BTRo79EjEGpWqOadGARUDCe_-XjkR2bKsXmOBACf6d3FY'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(width * 0.02),
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.edit, color: AppColors.whiteColor, size: width * 0.04),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    // CHANGED: was hardcoded 'Alex Johnson' — now real name from provider
                    Text(
                      user?.name ?? 'User',
                      style: AppTextStyle.headline28OnSurface,
                    ),
                    // CHANGED: was hardcoded email — now real email from provider
                    Text(
                      user?.email ?? '',
                      style: AppTextStyle.bodyLg16OnSurfaceVariant,
                    ),
                    SizedBox(height: height * 0.02),
                    // Stats kept as-is — needs results history (future feature)
                    Row(
                      children: [
                        StatCard(value: '42', label: 'Quizzes'),
                        SizedBox(width: width * 0.03),
                        StatCard(value: '850', label: 'Points'),
                        SizedBox(width: width * 0.03),
                        StatCard(value: '92%', label: 'Accuracy'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              Text('Account Settings', style: AppTextStyle.labelLg14OnSurfaceVariant),
              SizedBox(height: height * 0.01),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceColor,
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
                child: Column(
                  children: [
                    const ActionTile(icon: Icons.person_outline, label: 'Edit Profile'),
                    Divider(height: 1, color: AppColors.outlineVariantColor.withOpacity(0.3), indent: width * 0.04, endIndent: width * 0.04),
                    const ActionTile(icon: Icons.notifications_none, label: 'Notifications'),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              Text('Preferences', style: AppTextStyle.labelLg14OnSurfaceVariant),
              SizedBox(height: height * 0.01),
              Container(
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.surfaceColor,
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.dark_mode_outlined, color: AppColors.onSurfaceVariantColor, size: width * 0.06),
                        SizedBox(width: width * 0.03),
                        Text('Dark Mode', style: AppTextStyle.bodyLg16OnSurfaceVariant),
                      ],
                    ),
                    Switch(value: false, onChanged: (v) {}, activeColor: AppColors.primaryColor),
                  ],
                ),
              ),
              SizedBox(height: height * 0.04),
              // CHANGED: added GestureDetector so logout button actually works
              GestureDetector(
                onTap: _onLogoutTapped,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  decoration: BoxDecoration(
                    color: AppColors.errorContainer,
                    borderRadius: BorderRadius.circular(width * 0.03),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: AppColors.redColor, size: width * 0.05),
                      SizedBox(width: width * 0.02),
                      Text('Logout', style: AppTextStyle.bold14Red),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}

// StatCard and ActionTile widgets below — no changes needed
class StatCard extends StatelessWidget {
  final String value;
  final String label;

  const StatCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: width * 0.02),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(width * 0.02),
          border: Border.all(color: AppColors.onSurfaceVariantColor),
        ),
        child: Column(
          children: [
            Text(value, style: AppTextStyle.titleLg22Primary),
            Text(label, style: AppTextStyle.label12OnSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionTile({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.all(width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.onSurfaceVariantColor, size: width * 0.06),
              SizedBox(width: width * 0.03),
              Text(label, style: AppTextStyle.bodyLg16OnSurfaceVariant),
            ],
          ),
          Icon(Icons.chevron_right, color: AppColors.onSurfaceVariantColor, size: width * 0.06),
        ],
      ),
    );
  }
}