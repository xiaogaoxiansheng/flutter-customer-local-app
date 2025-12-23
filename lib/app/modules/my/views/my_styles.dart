import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyStyles {
  static TextStyle greeting(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF222222),
          );

  static TextStyle welcome(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 14.sp,
            color: const Color(0xFF9AA0A6),
          );

  static BoxDecoration infoCardDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      );

  static TextStyle infoTitle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 16.sp,
            color: const Color(0xFF333333),
          );

  static TextStyle infoTrailing(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 15.sp,
            color: const Color(0xFF999999),
          );

  static BoxDecoration logoutButtonDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFFF4D4F)),
      );

  static TextStyle logoutText(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 16.sp,
            color: const Color(0xFFFF4D4F),
          );
}

