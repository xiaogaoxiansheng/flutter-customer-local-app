import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 图库页面样式集中管理
class GalleryStyles {
  /// 页面背景色
  static const Color pageBackground = Colors.white;

  /// 空态/次要文字颜色
  static const Color textSecondary = Color(0xFF8E8E93);

  /// 图片加载占位背景色
  static const Color imagePlaceholder = Color(0xFFF2F4F7);

  /// 图片日期遮罩背景
  static const Color dateOverlayBackground = Color(0x66000000);

  /// 日期覆盖层渐变背景（自上透明到下半透明黑）
  static Gradient dateOverlayGradient() => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0x00000000),
          Color(0x99000000),
        ],
      );

  /// 预览页背景色
  static const Color previewBackground = Colors.black;

  /// 列表页左右边距
  static EdgeInsets listPadding() => EdgeInsets.symmetric(horizontal: 24.w);

  /// 列表页顶部间距
  static EdgeInsets listTopMargin() => EdgeInsets.only(top: 12.h);

  /// 九宫格布局参数
  static SliverGridDelegate gridDelegate() =>
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12.w,
        crossAxisSpacing: 12.w,
        childAspectRatio: 1,
      );

  /// “暂无图片”提示样式
  static TextStyle emptyText(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 28.sp,
            color: textSecondary,
          ) ??
      TextStyle(
        fontSize: 28.sp,
        color: textSecondary,
      );

  /// “正在加载...”提示样式
  static TextStyle loadingMoreText(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 24.sp,
            color: textSecondary,
          ) ??
      TextStyle(
        fontSize: 24.sp,
        color: textSecondary,
      );

  /// 日期覆盖层文字样式
  static TextStyle dateOverlayText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 22.sp,
            color: Colors.white,
          ) ??
      TextStyle(
        fontSize: 22.sp,
        color: Colors.white,
      );

  /// 预览底部信息栏文字样式
  static TextStyle previewBarText(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 26.sp,
            color: Colors.white,
          ) ??
      TextStyle(
        fontSize: 26.sp,
        color: Colors.white,
      );

  /// 日期覆盖层内边距
  static EdgeInsets dateOverlayPadding() =>
      EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h);

  /// 预览底部信息栏内边距
  static EdgeInsets previewBarPadding() =>
      EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h);

  /// 图片圆角
  static BorderRadius tileRadius() => BorderRadius.circular(12.r);

  /// 图片加载中圆形进度尺寸
  static double loadingIndicatorSize() => 28.w;

  /// 图片错误占位图标尺寸
  static double brokenImageIconSize() => 44.w;
}
