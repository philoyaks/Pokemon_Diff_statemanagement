import 'package:flutter/material.dart';

import '../../presentation/screens/Home_screen/tabar_widgets/custom_tab_indicator.dart';
import 'app_colors.dart';

class AppThemeData {
  static ThemeData appThemeData = ThemeData(
      fontFamily: 'Noto Sans',
      backgroundColor: AppColors.backgroundColor,
      primaryColor: AppColors.primaryColor,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColors.primaryColor),
      tabBarTheme: TabBarTheme(
        indicator: CustomTabIndicator(
            radius: 4, color: AppColors.primaryColor, height: 4),
        labelPadding: const EdgeInsets.symmetric(vertical: 14),
        unselectedLabelColor: const Color(0xff6b6b6b),
        labelColor: AppColors.textColorgrey,
        labelStyle: const TextStyle(
          color: AppColors.textColorgrey,
          fontSize: 16,
          fontFamily: "Noto Sans",
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Color(0xff6b6b6b),
          fontSize: 16,
        ),
      ));
}
