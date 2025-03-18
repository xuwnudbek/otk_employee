import 'package:flutter/material.dart';
import 'package:otk_employee/utils/theme/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        fontFamily: "Montserrat",
        scaffoldBackgroundColor: AppColors.secondary,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.secondary,
          primary: AppColors.primary,
        ),
        appBarTheme: AppBarTheme(
          elevation: 20,
          shadowColor: AppColors.dark.withValues(alpha: 0.2),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.secondary,
          surfaceTintColor: Colors.transparent,
        ),
        iconTheme: IconThemeData(size: 20),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.light,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fixedSize: const Size.fromHeight(48),
          ),
        ),
        dividerTheme: const DividerThemeData(
          space: 0,
          thickness: 1,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.primary.withValues(alpha: 0.1)),
            foregroundColor: WidgetStateProperty.all(AppColors.primary),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),
        ),
        shadowColor: AppColors.dark.withValues(alpha: 0.2),
        datePickerTheme: DatePickerThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        popupMenuTheme: PopupMenuThemeData(
          elevation: 5,
          textStyle: TextStyle(color: AppColors.dark),
          position: PopupMenuPosition.under,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: AppColors.light,
          surfaceTintColor: Colors.transparent,
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
}
