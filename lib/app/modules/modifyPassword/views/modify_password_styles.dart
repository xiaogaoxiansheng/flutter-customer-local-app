import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 修改密码页样式集中管理
/// 统一维护颜色、间距与文字样式
class ModifyPasswordStyles {
  // 页面背景色
  static const Color pageBackground = Colors.white;
  // 输入框背景色（浅灰）
  static const Color fieldBackground = Color(0xFFE9EEF3);
  // 文本主要颜色
  static const Color textPrimary = Color(0xFF1C1C1E);
  // 次要文字颜色（提示）
  static const Color textSecondary = Color(0xFF8E8E93);
  // 错误文字颜色（红色）
  static const Color textError = Color(0xFFFF4D4F);
  // 确定按钮背景色（浅绿）
  static const Color confirmBackground = Color(0xFFB4EFBF);

  /// 输入容器装饰（圆角浅灰背景）
  static BoxDecoration inputContainerDecoration() => BoxDecoration(
        color: fieldBackground,
        borderRadius: BorderRadius.circular(8.r),
      );

  /// 输入框内部边距
  static EdgeInsets inputPadding() => EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 0.h,
      );

  /// 输入框文字样式
  static TextStyle inputText(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 28.sp,
            color: textPrimary,
          );

  /// 输入框提示文字样式
  static TextStyle hintText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 28.sp,
            color: textSecondary,
          );

  /// 错误文字样式（红色）
  static TextStyle errorText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 26.sp,
            color: textError,
          );

  /// 确定按钮装饰（圆角浅绿背景）
  static BoxDecoration confirmButtonDecoration() => BoxDecoration(
        color: confirmBackground,
        borderRadius: BorderRadius.circular(8.r),
      );

  /// 确定按钮文字样式
  static TextStyle confirmText(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 30.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          );
}

