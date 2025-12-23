import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeLanguageStyles {
  static const Color primaryText = Color(0xFF222222);
  static const Color secondaryText = Color(0xFF9AA0A6);
  static const Color primaryGreen = Color(0xFF2DB84D);
  static const Color borderGray = Color(0xFFE0E0E0);
  static const Color confirmBackground = Color(0xFFB4EFBF);

  static TextStyle title(BuildContext context) => Theme.of(context)
      .textTheme
      .titleLarge!
      .copyWith(
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
        color: primaryText,
      );

  static TextStyle subtitle(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyMedium!
      .copyWith(
        fontSize: 14.sp,
        color: secondaryText,
      );

  static TextStyle languageLabel(bool selected) => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: selected ? primaryGreen : primaryText,
      );

  static Border languageBorder(bool selected) => Border.all(
        color: selected ? primaryGreen : borderGray,
        width: selected ? 2.0 : 1.0,
      );

  static BoxDecoration confirmButtonDecoration() => BoxDecoration(
        color: confirmBackground,
        borderRadius: BorderRadius.circular(16.r),
      );
}

