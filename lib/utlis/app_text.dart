import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyle {
  // --- العناوين الكبيرة (Headlines) ---
  static final TextStyle bold32Black = GoogleFonts.inter(
    color: AppColors.blackColor,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle medium28Black = GoogleFonts.inter(
    color: AppColors.blackColor,
    fontSize: 28,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle normal20DarkBlue = GoogleFonts.inter(
    color: AppColors.darkBlueColor,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
  // --- نصوص الأسئلة (Title) ---
  static final TextStyle medium22Black = GoogleFonts.inter(
    color: AppColors.blackColor,
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  // --- نصوص الجسم (Body) ---
  static final TextStyle normal16Black = GoogleFonts.inter(
    color: AppColors.blackColor,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static final TextStyle bold16Red = GoogleFonts.inter(
    color: AppColors.redColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle bold16Green = GoogleFonts.inter(
    color: Colors.green,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle normal16White = GoogleFonts.inter(
    color: AppColors.whiteColor,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static final TextStyle normal16Grey = GoogleFonts.inter(
    color: AppColors.greyColor,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static final TextStyle normal20White = GoogleFonts.inter(
    color: AppColors.whiteColor,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
  static final TextStyle bold16White = GoogleFonts.inter(
    color: AppColors.whiteColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  // --- نصوص الزراير والليبل (Labels) ---
  static final TextStyle bold16Purple = GoogleFonts.inter(
    color: AppColors.purpleColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle medium14White = GoogleFonts.inter(
    color: AppColors.whiteColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle medium14Black = GoogleFonts.inter(
    color: AppColors.blackColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  // --- نصوص التنبيهات والأخطاء ---
  static final TextStyle bold14Red = GoogleFonts.inter(
    color: AppColors.redColor,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle bold14White = GoogleFonts.inter(
    color: AppColors.whiteColor,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
}