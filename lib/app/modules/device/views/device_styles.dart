import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 设备页样式集中管理
/// 统一维护颜色、文字样式、装饰与间距
class DeviceStyles {
  // 页面背景色
  static const Color pageBackground = Colors.white;

  // 主品牌绿
  static const Color primaryGreen = Color(0xFF2DB84D);
  // 次要文本灰
  static const Color textSecondary = Color(0xFF8E8E93);
  // 轻边框
  static const Color borderLight = Color(0x11000000);
  // 操作按钮禁用灰
  static const Color disabledGray = Color(0xFFE5EAF0);
  // 标签灰背景
  static const Color chipGray = Color(0xFFE9EEF3);
  // 告警绿/橙
  static const Color okGreen = Color(0xFF28A745);
  static const Color warnOrange = Color(0xFFFFA000);

  /// 顶部位置文本样式
  static TextStyle locationText(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 26.sp,
            color: const Color(0xFF1C1C1E),
          );

  /// 顶部统计数字样式（大号）
  static TextStyle statisticNumber(bool good) => TextStyle(
        fontSize: 64.sp,
        fontWeight: FontWeight.w600,
        color: good ? primaryGreen : const Color(0xFFB0B3B8),
      );

  /// 顶部统计标签样式
  static TextStyle statisticLabelOnline() => TextStyle(
        fontSize: 22.sp,
        color: primaryGreen,
        fontWeight: FontWeight.w500,
      );

  static TextStyle statisticLabelOffline() => TextStyle(
        fontSize: 24.sp,
        color: textSecondary,
        fontWeight: FontWeight.w500,
      );

  /// 顶部分割线
  static Widget topDivider() => Container(
        height: 1.h,
        color: borderLight,
      );

  /// 顶部统计区中间竖分割线
  static Widget statVerticalDivider() => Container(
        width: 1.w,
        height: 32.h,
        color: borderLight,
        margin: EdgeInsets.symmetric(horizontal: 24.w),
      );

  /// 位置图按钮装饰
  static BoxDecoration positionButtonDecoration() => BoxDecoration(
        color: const Color(0xFFE8F6EE),
        borderRadius: BorderRadius.circular(8.r),
      );

  /// 位置图文字样式
  static TextStyle positionButtonText(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 26.sp,
            color: primaryGreen,
          );

  /// 操作按钮容器装饰
  static BoxDecoration actionButtonDecoration(Color bg) => BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12.r),
      );

  /// 操作按钮文字样式
  static TextStyle actionText(BuildContext context, Color color) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 24.sp,
            color: color,
          );


  /// 左侧型号灰色标签
  static BoxDecoration modelChipDecoration() => BoxDecoration(
        color: chipGray,
        borderRadius: BorderRadius.circular(400.r),
      );

  /// 型号标签文字
  static TextStyle modelChipText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 22.sp,
            color: const Color(0xFF9AA0A6),
          );

  /// 设备 ID 文本
  static TextStyle deviceIdText(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1C1C1E),
          );

  /// 方向与状态样式
  static TextStyle directionText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 24.sp,
            color: const Color(0xFF555B65),
          );

  static TextStyle ledOnText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 24.sp,
            color: okGreen,
            fontWeight: FontWeight.w500,
          );

  static TextStyle ledOffText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 24.sp,
            color: const Color(0xFFFF4D4F),
            fontWeight: FontWeight.w500,
          );

  static TextStyle alarmText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 22.sp,
            color: textSecondary,
          );

  /// 病虫标签
  static BoxDecoration bugBadgeDecoration(bool ok) => BoxDecoration(
        color: ok ? okGreen : warnOrange,
        borderRadius: BorderRadius.circular(4.r),
      );

  static TextStyle bugBadgeText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 22.sp,
            color: Colors.white,
          );
}

