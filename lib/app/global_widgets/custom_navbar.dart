import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBack;
  // 自定义背景色（默认白色）
  final Color backgroundColor;
  // 自定义标题颜色（默认黑色）
  final Color titleColor;
  // 自定义返回图标颜色（默认黑色）
  final Color iconColor;
  // 自定义阴影高度（默认 0）
  final double elevation;

  const CustomNavbar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBack,
    this.backgroundColor = Colors.white,
    this.titleColor = Colors.black,
    this.iconColor = Colors.black,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontSize: 36.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios, color: iconColor),
              onPressed: onBack ?? () => Get.back(),
            )
          : null,
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
