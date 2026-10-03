import 'package:flutter/material.dart';

class AppColors {
  // الألوان الأساسية
  static const Color purpleColor = Color(0xFF4F378A);      // Primary
  static const Color lightPurpleColor = Color(0xFF6750A4); // Primary Container
  static const Color softBlueColor = Color(0xFF665590);    // Secondary

  // الخلفيات
  static const Color bgLight = Color(0xFFFDF7FF);         // Background
  static const Color bgDark = Color(0xFF1C1B1F);          // Dark Mode Background

  // الرمادي والأسود (للنصوص)
  static const Color blackColor = Color(0xFF1D1B20);       // On Surface (Black)
  static const Color greyColor = Color(0xFF494551);        // Grey (Variant)
  static const Color outlineGrey = Color(0xFF7A7582);      // Outline

  // الأبيض والكروت
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFF2ECF4);        // Surface Container

  // ألوان الحالة
  static const Color redColor = Color(0xFFBA1A1A);         // Error
  static const Color successColor = Color(0xFF388E3C);     // Success

  static const Color transparentColor = Color(0x00FFFFFF);
  static const Color darkBlueColor = Color(0xff5669FF);
  static const Color primaryColor = Color(0xff4f378a);
  static const Color backgroundColor = Color(0xfffdf7ff);
  static const Color surfaceColor = Color(0xfff2ecf4);
  static const Color onSurfaceColor = Color(0xff1d1b20);
  static const Color onSurfaceVariantColor = Color(0xff494551);
  static const Color outlineVariantColor = Color(0xffcbc4d2);
  static const Color primaryFixedColor = Color(0xffe9ddff);
  static const Color secondaryContainerColor = Color(0xffd0bcff);
  static const Color tertiaryContainerColor = Color(0xffc9a74d);
  static const Color outlineColor = Color(0xffcbc4d2);
  static const Color lightPrimaryColor = Color(0xffe9ddff);
  static const Color primaryContainerColor = Color(0xFFE9DDFF);
  static const Color lightGreyColor = Color(0xffF2ECF4);
  static const Color borderColor = Color(0xffCBC4D2);
  static const Color primaryDarkColor = Color(0xff22005D);
  static const Color secondaryLightColor = Color(0xffD0BCFF);
  static const Color secondaryDarkColor = Color(0xff594983);
  static const Color redLightColor = Color(0xffFFDAD6);
  static const Color errorContainer = Color(0xffffdad6);
  static const Color primaryFixedDimColor = Color(0xffCFBCFF);
  static const Color secondaryGradientColor = Color(0x33D0BCFF);
  static const Color inversePrimaryGradientColor = Color(0x1ACFBCFF);
  static const Color trackColor = Color(0x33F2ECF4);

  // Creative Theme Colors
  static const Color vibrantOrange = Color(0xFFFF6D00);
  static const Color vibrantPink = Color(0xFFFF4081);
  static const Color vibrantBlue = Color(0xFF2979FF);
  static const Color vibrantGreen = Color(0xFF00E676);
  static const Color vibrantPurple = Color(0xFF651FFF);
  static const Color goldColor = Color(0xFFFFD700);

  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient greenGradient = LinearGradient(
    colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient lootBoxGradient = LinearGradient(
    colors: [Color(0xFF3A1C71), Color(0xFFD76D77), Color(0xFFFFAF7B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}