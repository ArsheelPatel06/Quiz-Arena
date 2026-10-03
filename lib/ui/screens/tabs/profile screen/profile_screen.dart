import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';                        
import '../../../../providers/auth_provider.dart';             
import '../../../../providers/quiz_provider.dart';             
import '../../../../core/services/auth_service.dart';          
import '../../../../utlis/app_colors.dart';
import '../../../../utlis/app_routes .dart';                   // NEW
import '../../../../utlis/app_text.dart';
import '../../../../utlis/dialog_utlis.dart';

// CHANGED: StatelessWidget → StatefulWidget
// Reason: we need to call logout() which is async
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // Removed unused _onLogoutTapped

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
                    Builder(
                      builder: (context) {
                        final quizProvider = context.watch<QuizProvider>();
                        final recentResults = quizProvider.recentResults;
                        
                        final int totalQuizzes = recentResults.length;
                        final int totalPoints = recentResults.fold(0, (sum, r) => sum + r.score * 10);
                        
                        double avgAccuracy = 0.0;
                        if (totalQuizzes > 0) {
                          avgAccuracy = recentResults.fold(0.0, (sum, r) => sum + r.percentage) / totalQuizzes;
                        }

                        return Row(
                          children: [
                            StatCard(value: '$totalQuizzes', label: 'Quizzes'),
                            SizedBox(width: width * 0.03),
                            StatCard(value: '$totalPoints', label: 'Points'),
                            SizedBox(width: width * 0.03),
                            StatCard(value: '${avgAccuracy.toStringAsFixed(0)}%', label: 'Accuracy'),
                          ],
                        );
                      }
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
                    ActionTile(
                      icon: Icons.person_outline, 
                      label: 'Edit Profile',
                      onTap: () {
                        DialogUtlis.showDialogMessage(
                          context: context, 
                          title: 'Edit Profile', 
                          middleText: 'Profile editing will be available in the next release!', 
                          buttonText: 'OK'
                        );
                      }
                    ),
                    Divider(height: 1, color: AppColors.outlineVariantColor.withOpacity(0.3), indent: width * 0.04, endIndent: width * 0.04),
                    ActionTile(
                      icon: Icons.notifications_none, 
                      label: 'Notifications',
                      onTap: () {
                        DialogUtlis.showDialogMessage(
                          context: context, 
                          title: 'Notifications', 
                          middleText: 'You have no new notifications.', 
                          buttonText: 'OK'
                        );
                      }
                    ),
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
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}

// StatCard and ActionTile widgets below
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
  final VoidCallback? onTap;

  const ActionTile({super.key, required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: onTap,
      child: Padding(
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
      ),
    );
  }
}