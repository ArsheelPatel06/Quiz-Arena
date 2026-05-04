import 'package:flutter/material.dart';
import '../../../../utlis/app_colors.dart';
import '../../../../utlis/app_text.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

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
                    Text('Alex Johnson', style: AppTextStyle.headline28OnSurface),
                    Text('alex.johnson@example.com', style: AppTextStyle.bodyLg16OnSurfaceVariant),
                    SizedBox(height: height * 0.02),
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
              Container(
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
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}

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