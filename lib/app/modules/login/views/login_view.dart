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
                  stops: [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: AvifImage.asset(
              'assets/images/other_login_bg.avif',
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => const SizedBox.shrink(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ConstraintLayout(
                children: [
                  AvifImage.asset(
                    'assets/images/other_home_logo.avif',
                    width: 64.w,
                    height: 64.w,
                    errorBuilder: (c, e, s) => const FlutterLogo(size: 48),
                  ).applyConstraint(
                    id: ConstraintId('logo'),
                    right: parent.right,
                    top: parent.top,
                  ),
                  Text('登录', style: LoginStyles.title(context)).applyConstraint(
                    id: ConstraintId('title'),
                    left: parent.left,
                    top: parent.bottom,
                  ),
                  Text(
                    '储粮害虫半导体光诱捕系统·客户端',
                    style: LoginStyles.subtitle(context),
                  ).applyConstraint(
                    id: ConstraintId('subtitle'),
                    left: parent.left,
                    top: ConstraintId('title').bottom,
                  ),
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: SingleChildScrollView(
                        child: controller.tabIndex.value == 0
                            ? _UserForm(controller: controller)
                            : _PhoneForm(controller: controller),
                      ),
                    ),
                  ).applyConstraint(
                    id: ConstraintId('form'),
                    left: parent.left,
                    right: parent.right,
                    top: ConstraintId('subtitle').bottom,
                    bottom: parent.bottom,
                  ),
                  Obx(
                    () => controller.errorMessage.value.isEmpty
                        ? const SizedBox.shrink()
                        : SelectableText.rich(
                            TextSpan(
                              text: controller.errorMessage.value,
                              style: const TextStyle(color: Colors.red),
                            ),
                            textAlign: TextAlign.center,
                          ),
                  ).applyConstraint(
                    id: ConstraintId('error'),
                    left: parent.left,
                    right: parent.right,
                    bottom: parent.bottom,
                  ),
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
              width: 20.w,
              height: 20.w,
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
                width: 20.w,
                height: 20.w,
                errorBuilder: (c, e, s) => const Icon(Icons.lock),
              ),
              suffix: GestureDetector(
                onTap: controller.toggleObscure,
                child: AvifImage.asset(
                  controller.isObscure.value
                      ? 'assets/images/login_hidden.avif'
                      : 'assets/images/login_show.avif',
                  width: 20.w,
                  height: 20.w,
                  errorBuilder: (c, e, s) => Icon(
                    controller.isObscure.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
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

// 【AI修改】 手机验证码表单
class _PhoneForm extends StatelessWidget {
  final LoginController controller;
  const _PhoneForm({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller.phoneController,
          decoration: LoginStyles.inputDecoration(
            hint: '请输入手机号',
            prefix: AvifImage.asset(
              'assets/images/login_phone.avif',
              width: 20.w,
              height: 20.w,
              errorBuilder: (c, e, s) => const Icon(Icons.phone),
            ),
          ),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 12.h),
        TextField(
          controller: controller.codeController,
          decoration: LoginStyles.inputDecoration(
            hint: '请输入验证码',
            prefix: const Icon(Icons.sms),
          ),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
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
