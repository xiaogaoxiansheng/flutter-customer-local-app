import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import './login_styles.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2DB84D),
                    Color(0xFF66CF7D),
                    Colors.white,
                  ],
                  stops: [0.0, 0.3, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            width: 1.sw,
            child: AvifImage.asset(
              'assets/images/other_login_bg.avif',
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => const SizedBox.shrink(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: ConstraintLayout(
                children: [
                  AvifImage.asset(
                    'assets/images/other_home_logo.avif',
                    width: 64.w,
                  ).applyConstraint(
                    id: ConstraintId('logo'),
                    left: parent.left,
                    top: parent.top,
                    margin: EdgeInsets.only(top: 180.h),
                  ),
                  Text('登录', style: LoginStyles.title(context)).applyConstraint(
                    id: ConstraintId('title'),
                    left: parent.left,
                    top: ConstraintId('logo').bottom,
                    margin: EdgeInsets.only(top: 10.h),
                  ),
                  Text(
                    '储粮害虫半导体光诱捕系统·客户端',
                    style: LoginStyles.subtitle(context),
                  ).applyConstraint(
                    id: ConstraintId('subtitle'),
                    left: parent.left,
                    top: ConstraintId('title').bottom,
                    margin: EdgeInsets.only(top: 6.h),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: SingleChildScrollView(
                      child: _UserForm(controller: controller),
                    ),
                  ).applyConstraint(
                    id: ConstraintId('form'),
                    left: parent.left,
                    right: parent.right,
                    top: ConstraintId('subtitle').bottom,
                    margin: EdgeInsets.only(top: 50.h),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//用户名密码表单
class _UserForm extends StatelessWidget {
  final LoginController controller;
  const _UserForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _IconInput(
          controller: controller.usernameController,
          iconAsset: 'assets/images/login_user.avif',
          hint: 'Admin',
          obscureText: false,
          textInputAction:  TextInputAction.next,
          iconSize: 40.w,
        ),
        SizedBox(height: 12.h),
        Obx(
          () => _IconInput(
            controller: controller.passwordController,
            iconAsset: 'assets/images/login_phone.avif',
            hint: '••••••••',
            obscureText: controller.isObscure.value,
            textInputAction: TextInputAction.done,
            iconSize: 40.w,
          ),
        ),
        SizedBox(height: 20.h),
        ElevatedButton(
          style: LoginStyles.loginButton(),
          onPressed: controller.login,
          child: const Text('登录'),
        ),
      ],
    );
  }
}

// 图标输入框
class _IconInput extends StatelessWidget {
  final TextEditingController controller;
  final String iconAsset;
  final String? hint;
  final bool obscureText;
  final TextInputAction textInputAction;
  final double iconSize;

  const _IconInput({
    required this.controller,
    required this.iconAsset,
    this.hint,
    required this.obscureText,
    required this.textInputAction,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: LoginStyles.fieldFill,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0x11000000)),
      ),
      child: ConstraintLayout(
        children: [
          AvifImage.asset(
            iconAsset,
            width: iconSize,
            fit: BoxFit.contain,
            errorBuilder: (c, e, s) => Icon(
              Icons.image_not_supported,
              size: iconSize,
            ),
          ).applyConstraint(
            id: ConstraintId('icon'),
            left: parent.left,
            top: parent.top,
            bottom: parent.bottom,
            margin: EdgeInsets.only(left: 20.w),
          ),
          TextField(
            controller: controller,
            decoration: LoginStyles.plainInputDecoration(hint: hint),
            obscureText: obscureText,
            textInputAction: textInputAction,
            textCapitalization: TextCapitalization.none,
          ).applyConstraint(
            id: ConstraintId('field'),
            left: ConstraintId('icon').right,
            top: parent.top,
            bottom: parent.bottom,
            margin: EdgeInsets.only(left: 12.w,top: 4.h),
          ),
        ],
      ),
    );
  }
}

 
