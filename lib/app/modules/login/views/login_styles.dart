import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginStyles {
  static const Color primaryGreen = Color(0xFF2DB84D);
  static const Color primaryText = Colors.white;
  static const Color fieldFill = Colors.white;

  static TextStyle title(BuildContext context) => Theme.of(context)
      .textTheme
      .titleLarge!
      .copyWith(color: primaryText, fontWeight: FontWeight.w700, fontSize: 52.sp);

  static TextStyle subtitle(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyMedium!
      .copyWith(color: primaryText.withValues(alpha: 0.9), fontSize: 24.sp);

  static InputDecoration plainInputDecoration({
    String? hint,
  }) => InputDecoration(
        hintText: hint,
        isDense: true,
        filled: false,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
      );

  static InputDecoration inputDecoration({
    String? hint,
    Widget? prefix,
    Widget? suffix,
  }) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: fieldFill,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 12.h),
        prefixIcon: prefix == null
            ? null
            : Padding(padding: EdgeInsets.all(8.w), child: prefix),
        suffixIcon: suffix == null
            ? null
            : Padding(padding: EdgeInsets.all(8.w), child: suffix),
        prefixIconConstraints: BoxConstraints(
          minWidth: 52.w,
          minHeight: 40.w,
          maxWidth: 72.w,
          maxHeight: 40.w,
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 48.w,
          minHeight: 40.w,
          maxWidth: 72.w,
          maxHeight: 40.w,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: const Color(0x11000000)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: const Color(0x11000000)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: const Color(0x33000000)),
        ),
      );

  static ButtonStyle loginButton() => ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 42.h),
        textStyle: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      );
}
