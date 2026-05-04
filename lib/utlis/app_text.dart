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

  static final TextStyle bold32Primary = GoogleFonts.inter(
    color: AppColors.primaryColor,
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle medium28Black = GoogleFonts.inter(
    color: AppColors.blackColor,
    fontSize: 28,
    fontWeight: FontWeight.w500,
  );

  // تم دمج headlineMd28OnSurface هنا
  static final TextStyle headline28OnSurface = GoogleFonts.inter(
    color: AppColors.onSurfaceColor, // أو AppColors.onSurface
    fontSize: 28,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle regular57PrimaryDark = GoogleFonts.inter(
    color: AppColors.primaryDarkColor,
    fontSize: 57,
    fontWeight: FontWeight.w400,
  );

  // --- نصوص الأسئلة والعناوين الفرعية (Titles) ---
  static final TextStyle title22OnSurface = GoogleFonts.inter(
    color: AppColors.onSurfaceColor,
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle medium22Black = GoogleFonts.inter(
    color: AppColors.blackColor,
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle titleLg22Primary = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor,
  );

  static final TextStyle title20Primary = GoogleFonts.inter(
    color: AppColors.primaryColor,
    fontSize: 20,
    fontWeight: FontWeight.w900,
  );

  static final TextStyle normal20DarkBlue = GoogleFonts.inter(
    color: AppColors.darkBlueColor,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle normal20White = GoogleFonts.inter(
    color: AppColors.whiteColor,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

  // --- نصوص الجسم (Body) ---
  // تم دمج regular16Black و bodyLg16OnSurface هنا
  static final TextStyle normal16Black = GoogleFonts.inter(
    color: AppColors.blackColor,
    fontSize: 16,
    fontWeight: FontWeight.normal, // FontWeight.w400
  );

  static final TextStyle medium16Black = GoogleFonts.inter(
    color: AppColors.blackColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle bodyLg16OnSurfaceVariant = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariantColor,
  );

  static final TextStyle normal16White = GoogleFonts.inter(
    color: AppColors.whiteColor,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bold16White = GoogleFonts.inter(
    color: AppColors.whiteColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle normal16Grey = GoogleFonts.inter(
    color: AppColors.greyColor,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bold16Purple = GoogleFonts.inter(
    color: AppColors.purpleColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
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

  // --- نصوص الزراير والليبل (Labels 14px) ---
  static final TextStyle label14OnSurface = GoogleFonts.inter(
    color: AppColors.onSurfaceColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
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

  static final TextStyle medium14Grey = GoogleFonts.inter(
    color: AppColors.greyColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle regular14Grey = GoogleFonts.inter(
    color: AppColors.greyColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle body14OnSurfaceVariant = GoogleFonts.inter(
    color: AppColors.onSurfaceVariantColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  // تم دمج bold14Primary هنا
  static final TextStyle label14Primary = GoogleFonts.inter(
    color: AppColors.primaryColor,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle medium14Primary = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor,
  );

  static final TextStyle medium14SecondaryDark = GoogleFonts.inter(
    color: AppColors.secondaryDarkColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle labelLg14OnSurfaceVariant = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurfaceVariantColor,
  );

  // تم دمج labelLg14BoldError هنا
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

  // --- نصوص صغيرة (12px) ---
  // تم دمج medium12Grey هنا
  static final TextStyle label12OnSurfaceVariant = GoogleFonts.inter(
    color: AppColors.onSurfaceVariantColor, // أو AppColors.greyColor
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle medium12Black = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
  );

  static final TextStyle normal12Grey = GoogleFonts.inter(
    color: AppColors.greyColor,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle bold12White = GoogleFonts.inter(
    color: AppColors.whiteColor,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
}