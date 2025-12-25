import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 告警页面样式集中管理类
class AlarmStyles {
  // 页面背景色
  static const Color pageBackground = Colors.white;
  // 主色调（绿色）
  static const Color primaryGreen = Color(0xFF2DB84D);
  // 搜索框及标签背景色
  static const Color searchFill = Color(0xFFF2F4F7);
  // 浅色边框颜色
  static const Color borderLight = Color(0x11000000);
  // 主要文本颜色
  static const Color textPrimary = Color(0xFF1C1C1E);
  // 次要文本颜色
  static const Color textSecondary = Color(0xFF8E8E93);

  /// 搜索框装饰样式
  static BoxDecoration searchDecoration() => BoxDecoration(
        color: searchFill,
        borderRadius: BorderRadius.circular(12.r),
      );

  /// 搜索框提示文字样式
  static TextStyle searchHint(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyMedium!
      .copyWith(color: textSecondary, fontSize: 28.sp);

  /// 顶部标签页装饰样式
  /// [isSelected] 是否选中
  static BoxDecoration tabDecoration({
    required bool isSelected,
  }) => BoxDecoration(
        color: isSelected ? primaryGreen : searchFill,
        borderRadius: BorderRadius.circular(10.r),
      );

  /// 顶部标签页文字样式
  /// [isSelected] 是否选中
  static TextStyle tabLabel({
    required bool isSelected,
  }) => TextStyle(
        color: isSelected ? Colors.white : textPrimary,
        fontSize: 28.sp,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      );

  /// 告警列表项标题样式
  static TextStyle alarmTitle(BuildContext context) => Theme.of(context)
      .textTheme
      .titleMedium!
      .copyWith(
        color: textPrimary,
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
      );

  /// 告警类型标签装饰样式
  /// [color] 标签主题色
  static BoxDecoration alarmTagDecoration(Color color) => BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(32.r),
      );

  /// 告警类型标签文字样式
  /// [color] 文字颜色
  static TextStyle alarmTagText(Color color) => TextStyle(
        color: color,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      );

  /// 详情芯片（SN/型号）装饰样式
  static BoxDecoration chipDecoration() => BoxDecoration(
        color: searchFill,
        borderRadius: BorderRadius.circular(32.r),
      );

  /// 详情芯片（SN/型号）文字样式
  static TextStyle chipText() => TextStyle(
        color: textSecondary,
        fontSize: 26.sp,
        fontWeight: FontWeight.w500,
      );

  /// 元数据行（位置/地址/时间）文字样式
  static TextStyle metaText() => TextStyle(
        color: textSecondary,
        fontSize: 26.sp,
        fontWeight: FontWeight.w500,
      );
}

