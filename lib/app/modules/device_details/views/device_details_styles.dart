import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 设备详情页样式集中管理
/// 统一维护颜色、文字样式、装饰与间距
class DeviceDetailsStyles {
  /// 页面背景色
  static const Color pageBackground = Color(0xFFF6F7F9);

  /// 卡片背景色
  static const Color cardBackground = Colors.white;

  /// 主品牌绿
  static const Color primaryGreen = Color(0xFF2DB84D);

  /// 次要文本灰
  static const Color textSecondary = Color(0xFF8E8E93);

  /// 主文本色
  static const Color textPrimary = Color(0xFF1C1C1E);

  /// 轻边框
  static const Color borderLight = Color(0x11000000);

  /// 告警橙
  static const Color warnOrange = Color(0xFFFFA000);

  /// AI 识别标签紫
  static const Color aiPurple = Color(0xFFB05BFF);

  /// 页面水平内边距
  static EdgeInsets pagePadding() => EdgeInsets.symmetric(horizontal: 10.w);

  /// 顶部主卡片外边距
  static EdgeInsets headerCardMargin() =>
      EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h);

  /// 标准卡片圆角
  static BorderRadius cardRadius() => BorderRadius.circular(0.r);

  /// 标准卡片装饰
  static BoxDecoration cardDecoration() => BoxDecoration(
        color: cardBackground,
        borderRadius: cardRadius(),
      );

  /// 设备 ID 文本
  static TextStyle deviceIdText(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 30.sp,
            fontWeight: FontWeight.w700,
            color: textPrimary,
          );

  /// 型号标签装饰
  static BoxDecoration modelChipDecoration() => BoxDecoration(
        color: primaryGreen.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.r),
      );

  /// 型号标签文本
  static TextStyle modelChipText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 22.sp,
            color: primaryGreen,
            fontWeight: FontWeight.w700,
          );

  /// 状态标题文本
  static TextStyle statusTitleText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 22.sp,
            color: textSecondary,
          );

  /// 状态值文本
  static TextStyle statusValueText(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 24.sp,
            color: textPrimary,
            fontWeight: FontWeight.w600,
          );

  /// 次级信息行文本
  static TextStyle metaText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 22.sp,
            color: textSecondary,
          );

  /// 分组标题文本
  static TextStyle sectionTitleText(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 26.sp,
            fontWeight: FontWeight.w700,
            color: textPrimary,
          );

  /// 分组右侧操作文本
  static TextStyle sectionActionText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 22.sp,
            color: textSecondary,
          );

  /// 功能按钮装饰
  static BoxDecoration actionTileDecoration() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            primaryGreen.withValues(alpha: 0.01),
            primaryGreen.withValues(alpha: 0.05),
          ],
          stops: [0.1,0.1, 0.3],
        ),
        borderRadius: BorderRadius.circular(16.r),
      );

  /// 功能按钮文字
  static TextStyle actionTileText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 22.sp,
            color: primaryGreen,
            fontWeight: FontWeight.w600,
          );

  /// 分割线
  static Widget divider() => Container(
        height: 1.h,
        color: borderLight,
      );

  /// AI 标签装饰
  static BoxDecoration aiChipDecoration() => BoxDecoration(
        color: aiPurple.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999.r),
      );

  /// AI 标签文本
  static TextStyle aiChipText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 20.sp,
            color: aiPurple,
            fontWeight: FontWeight.w700,
          );

  /// 传感器条目名称
  static TextStyle sensorNameText(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 24.sp,
            color: textSecondary,
            fontWeight: FontWeight.w400,
          );

  /// 传感器离线标签文本
  static TextStyle sensorOfflineText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 18.sp,
            color: warnOrange,
            fontWeight: FontWeight.w500,
          );

  /// 传感器离线标签装饰
  static BoxDecoration sensorOfflineDecoration() => BoxDecoration(
        color: warnOrange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      );

  /// 传感器条目数值
  static TextStyle sensorValueText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 22.sp,
            color: textSecondary,
          );

  /// 告警状态文本
  static TextStyle warnText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 22.sp,
            color: warnOrange,
            fontWeight: FontWeight.w700,
          );

  /// 告警列表标签文本
  static TextStyle alarmTagText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 20.sp,
            color: warnOrange,
            fontWeight: FontWeight.w500,
          );

  /// 告警列表标签装饰
  static BoxDecoration alarmTagDecoration() => BoxDecoration(
        color: warnOrange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
      );

  /// 告警内容文本
  static TextStyle alarmContentText(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 24.sp,
            color: textSecondary,
            fontWeight: FontWeight.w400,
          );

  /// 告警时间文本
  static TextStyle alarmTimeText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 22.sp,
            color: textSecondary,
            fontWeight: FontWeight.w400,
          );

  /// 信息卡片装饰（带顶部边框）
  static BoxDecoration infoCardDecoration() => BoxDecoration(
        color: cardBackground,
        border: Border(
          top: BorderSide(
            color: borderLight,
            width: 1.h,
          ),
        ),
      );
}
