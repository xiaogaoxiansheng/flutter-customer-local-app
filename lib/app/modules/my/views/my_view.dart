import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './my_styles.dart';
import '../../../global_widgets/custom_navbar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/my_controller.dart';

class MyView extends GetView<MyController> {
  const MyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomNavbar(
        title: '我',
        showBackButton: false,
      ),
      body: ConstraintLayout(
        children: [
          Text(
            'Hi，刘海涛',
            style: MyStyles.greeting(context),
          ).applyConstraint(
            id: ConstraintId('greet'),
            left: parent.left,
            top: parent.top,
            margin: EdgeInsets.only(left: 24.w, top: 24.h),
          ),
          Text(
            '欢迎使用',
            style: MyStyles.welcome(context),
          ).applyConstraint(
            id: ConstraintId('welcome'),
            left: parent.left,
            top: ConstraintId('greet').bottom,
            margin: EdgeInsets.only(left: 24.w, top: 4.h),
          ),
          _MyInfoCard().applyConstraint(
            id: ConstraintId('card'),
            left: parent.left,
            right: parent.right,
            top: ConstraintId('welcome').bottom,
            margin: EdgeInsets.only(top: 40.h),
          ),
          _LogoutButton().applyConstraint(
            id: ConstraintId('logout'),
            left: parent.left,
            right: parent.right,
            top: ConstraintId('card').bottom,
            margin: EdgeInsets.only(top: 60.h),
          ),
        ],
      ),
    );
  }
}

// 个人信息
class _MyInfoCard extends StatelessWidget {
  const _MyInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: MyStyles.infoCardDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MyInfoItem(
            leading: AvifImage.asset(
              'assets/images/login_user.avif',
              width: 40.w,
              height: 40.w,
              errorBuilder: (c, e, s) => const Icon(Icons.person_outline),
            ),
            title: '账号',
            trailingText: 'Admin',
          ),
          _MyInfoItem(
            leading: AvifImage.asset(
              'assets/images/login_phone.avif',
              width: 40.w,
              height: 40.w,
              errorBuilder: (c, e, s) => const Icon(Icons.phone_iphone),
            ),
            title: '手机号',
            trailingText: '156 2061 2220',
          ),
          SizedBox(height: 12.h),
          _MyInfoItem(
            leading: AvifImage.asset(
              'assets/images/my_info.avif',
              width: 40.w,
              height: 40.w,
              errorBuilder: (c, e, s) =>
                  const Icon(Icons.report_problem_outlined),
            ),
            title: '故障上报',
            showArrow: true,
          ),
          _MyInfoItem(
            leading: AvifImage.asset(
              'assets/images/my_key.avif',
              width: 40.w,
              height: 40.w,
              errorBuilder: (c, e, s) => const Icon(Icons.vpn_key_outlined),
            ),
            title: '修改密码',
            showArrow: true,
            onTap: () => Get.toNamed(Routes.modifyPassword),
          ),
        ],
      ),
    );
  }
}

class _MyInfoItem extends StatelessWidget {
  final Widget leading;
  final String title;
  final String? trailingText;
  final bool showArrow;
  final VoidCallback? onTap;

  const _MyInfoItem({
    required this.leading,
    required this.title,
    this.trailingText,
    this.showArrow = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(width: 16.w),
            SizedBox(
              width: 40.w,
              height: 40.w,
              child: leading,
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: MyStyles.infoTitle(context),
            ),
            const Spacer(),
            if (trailingText != null)
              Text(
                trailingText!,
                style: MyStyles.infoTrailing(context),
              ),
            if (showArrow)
              Icon(
                Icons.chevron_right,
                size: 38.w,
                color: const Color(0xFFCCCCCC),
              ),
            SizedBox(width: 16.w),
          ],
        ),
      ),
    );
  }
}

// 退出登录按钮
class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 190.w),
      height: 48.h,
      decoration: MyStyles.logoutButtonDecoration(),
      alignment: Alignment.center,
      child: Text(
        '退出登录',
        style: MyStyles.logoutText(context),
      ),
    );
  }
}
