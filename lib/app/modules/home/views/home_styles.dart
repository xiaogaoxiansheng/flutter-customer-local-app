import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/home_controller.dart';

/// 首页（粮仓详情列表）样式集中管理
class HomeStyles {
  /// 页面背景色
  static const Color pageBackground = Color(0xFFFFFFFF);

  /// 主品牌绿
  static const Color primaryGreen = Color(0xFF2DB84D);

  /// 指标蓝
  static const Color metricBlue = Color(0xFF2D7CFF);

  /// 指标橙
  static const Color metricOrange = Color(0xFFFFA000);

  /// 主要文字颜色
  static const Color textPrimary = Color(0xFF1C1C1E);

  /// 次要文字颜色
  static const Color textSecondary = Color(0xFF8E8E93);

  /// 卡片浅边框
  static const Color borderLight = Color(0x11000000);

  /// 顶部背景高度
  static double headerHeight() => 260.h;

  /// 顶部渐变背景（调整为更贴近设计图的线性渐变）
  static BoxDecoration headerDecoration() => const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF3AC149),
            Color(0xFF2DB84D),
          ],
        ),
      );

  /// 顶部内容内边距（增大上边距，让主标题位置更接近设计图）
  static EdgeInsets headerPadding() =>
      EdgeInsets.fromLTRB(32.w, 40.h, 32.w, 0);

  /// 顶部白色圆角容器装饰（增加顶部圆角使内容区域更像卡片）
  static BoxDecoration contentContainerDecoration() => BoxDecoration(
        color: pageBackground,      );

  /// 顶部主标题样式
  static TextStyle headerTitle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 48.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          );

  /// 顶部副标题样式
  static TextStyle headerSubtitle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 38.sp,
            color: const Color(0xFFFFFFFF),
          );

  /// 库点名称文字样式
  static TextStyle warehouseTitle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 44.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          );

  /// 右上角操作胶囊装饰
  static BoxDecoration actionPillDecoration() => BoxDecoration(
        color: const Color(0xCCFFFFFF),
        borderRadius: BorderRadius.circular(999.r),
      );

  /// 右上角分割线颜色
  static Color pillDividerColor() => const Color(0x22000000);


  /// 在线数量文字样式
  static TextStyle onlineNumber(BuildContext context) =>
      Theme.of(context).textTheme.displaySmall!.copyWith(
            fontSize: 72.sp,
            fontWeight: FontWeight.w700,
            color: textPrimary,
          );

  /// 在线/全部描述样式
  static TextStyle onlineLabel(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 26.sp,
            color: textSecondary,
          );

  /// 汇总卡片中间竖分割线
  static Widget summaryDivider() => Container(
        width: 1.w,
        height: 72.h,
        color: borderLight.withOpacity(0.6),
        margin: EdgeInsets.symmetric(horizontal: 24.w),
      );

  /// 顶部指标行样式
  static TextStyle metricLabelStyle(BuildContext context, Color color) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 26.sp,
            color: color,
            fontWeight: FontWeight.w600,
          );

  /// 顶部指标右侧信息样式
  static TextStyle metricGranaryStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 30.sp,
            color: textPrimary,
          );

  /// 库点位置文字样式
  static TextStyle locationText(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 32.sp,
            color: textPrimary,
            fontWeight: FontWeight.w600,
          );

  /// 分区标题行外边距
  static EdgeInsets sectionMargin() => EdgeInsets.fromLTRB(32.w, 14.h, 32.w, 0);

  /// 分区标题文字样式
  static TextStyle sectionTitle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 32.sp,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          );

  /// 列表外边距
  static EdgeInsets listPadding() => EdgeInsets.fromLTRB(32.w, 16.h, 32.w, 0.h);

  /// 粮仓卡片装饰
  static BoxDecoration cardDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(42.r),
        border: Border.all(color: borderLight),
      );

  /// 粮仓卡片顶部高度（略微增高以突出标题区）
  static double cardHeaderHeight() => 132.h;

  /// 粮仓卡片顶部圆角
  static BorderRadius cardHeaderRadius() => BorderRadius.circular(26.r);

  /// 粮仓卡片内部背景图圆角（略小于外层，保留间距）
  static BorderRadius cardInnerHeaderRadius() => BorderRadius.circular(28.r);


  /// 粮仓卡片顶部背景图（根据不同等级选择不同资源）
  static String cardHeaderBackgroundAsset(HomeAlertLevel level) {
    return switch (level) {
      HomeAlertLevel.normal => 'assets/images/other_home_card01.avif',
      HomeAlertLevel.warning => 'assets/images/other_home_card02.avif',
      HomeAlertLevel.danger => 'assets/images/other_home_card02.avif',
    };
  }

  /// 卡片编号文字样式
  static TextStyle cardIdText(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 48.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          );

  /// 卡片更新时间文字样式
  static TextStyle cardUpdateText(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 22.sp,
            color: const Color(0xDDFFFFFF),
          );

  /// 卡片内容区内边距
  static EdgeInsets cardBodyPadding() => EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 16.h,
      );

  /// 卡片指标标题样式
  static TextStyle cardMetricLabel(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 26.sp,
            color: textPrimary,
          );

  /// 卡片指标数值样式
  static TextStyle cardMetricValue(BuildContext context, {Color? color}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
            color: color ?? textPrimary,
          );

  /// 卡片内容分割线
  static Widget cardDividerVertical() => Container(
        width: 1.w,
        color: borderLight,
      );

  /// 加载更多文字样式
  static TextStyle loadingMoreText(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 24.sp,
            color: textSecondary,
          );
}
