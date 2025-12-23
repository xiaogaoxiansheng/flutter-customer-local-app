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

// 【AI修改】 用户名密码表单
class _UserForm extends StatelessWidget {
  final LoginController controller;
  const _UserForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller.usernameController,
          decoration: LoginStyles.inputDecoration(
            hint: 'Admin',
            prefix: AvifImage.asset(
              'assets/images/login_user.avif',
              width: 16.w,
              height: 16.w,
              errorBuilder: (c, e, s) => const Icon(Icons.person),
            ),
          ),
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.none,
        ),
        SizedBox(height: 12.h),
        Obx(
          () => TextField(
            controller: controller.passwordController,
            decoration: LoginStyles.inputDecoration(
              hint: '••••••••',
              prefix: AvifImage.asset(
                'assets/images/login_phone.avif',
                width: 16.w,
                height: 16.w,
                errorBuilder: (c, e, s) => const Icon(Icons.lock),
              ),
              
            ),
            obscureText: controller.isObscure.value,
            textInputAction: TextInputAction.done,
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

 
