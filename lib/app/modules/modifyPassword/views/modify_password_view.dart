import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../global_widgets/custom_navbar.dart';
import '../controllers/modify_password_controller.dart';
import './modify_password_styles.dart';

/// 修改密码页视图
/// 按设计稿布局，包含 3 个密码输入与确认按钮
class ModifyPasswordView extends GetView<ModifyPasswordController> {
  const ModifyPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ModifyPasswordStyles.pageBackground,
      appBar: const CustomNavbar(title: '修改密码'),
      body: ConstraintLayout(
        children: [
          // 输入原密码
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            padding: ModifyPasswordStyles.inputPadding(),
            decoration: ModifyPasswordStyles.inputContainerDecoration(),
            child: Obx(() => TextField(
                  controller: controller.oldPasswordController,
                  obscureText: controller.isObscureOld.value,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  textAlignVertical: TextAlignVertical.center,
                  style: ModifyPasswordStyles.inputText(context),
                  decoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: '输入原密码',
                    hintStyle: ModifyPasswordStyles.hintText(context),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isObscureOld.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xFF9AA0A6),
                      ),
                      onPressed: controller.toggleObscureOld,
                    ),
                  ),
                )),
          ).applyConstraint(
            id: ConstraintId('old'),
            left: parent.left,
            right: parent.right,
            top: parent.top,
            margin: EdgeInsets.only(top: 12.h),
          ),

          // 输入新密码
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            padding: ModifyPasswordStyles.inputPadding(),
            decoration: ModifyPasswordStyles.inputContainerDecoration(),
            child: Obx(() => TextField(
                  controller: controller.newPasswordController,
                  obscureText: controller.isObscureNew.value,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  textAlignVertical: TextAlignVertical.center,
                  style: ModifyPasswordStyles.inputText(context),
                  decoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: '输入新密码',
                    hintStyle: ModifyPasswordStyles.hintText(context),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isObscureNew.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xFF9AA0A6),
                      ),
                      onPressed: controller.toggleObscureNew,
                    ),
                  ),
                )),
          ).applyConstraint(
            id: ConstraintId('new'),
            left: parent.left,
            right: parent.right,
            top: ConstraintId('old').bottom,
            margin: EdgeInsets.only(top: 12.h),
          ),

          // 确认新密码
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            padding: ModifyPasswordStyles.inputPadding(),
            decoration: ModifyPasswordStyles.inputContainerDecoration(),
            child: Obx(() => TextField(
                  controller: controller.confirmPasswordController,
                  obscureText: controller.isObscureConfirm.value,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.done,
                  textAlignVertical: TextAlignVertical.center,
                  style: ModifyPasswordStyles.inputText(context),
                  decoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: '确认新密码',
                    hintStyle: ModifyPasswordStyles.hintText(context),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isObscureConfirm.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xFF9AA0A6),
                      ),
                      onPressed: controller.toggleObscureConfirm,
                    ),
                  ),
                )),
          ).applyConstraint(
            id: ConstraintId('confirm'),
            left: parent.left,
            right: parent.right,
            top: ConstraintId('new').bottom,
            margin: EdgeInsets.only(top: 12.h),
          ),

          // 确定按钮
          Obx(() {
            final loading = controller.isLoading.value;
            return GestureDetector(
              onTap: loading ? null : controller.submit,
              child: Container(
                height: 55.h,
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                alignment: Alignment.center,
                decoration: ModifyPasswordStyles.confirmButtonDecoration(),
                child: Text(
                  loading ? '处理中...' : '确定',
                  style: ModifyPasswordStyles.confirmText(context),
                ),
              ),
            );
          }).applyConstraint(
            id: ConstraintId('confirmBtn'),
            left: parent.left,
            right: parent.right,
            top: ConstraintId('confirm').bottom,
            margin: EdgeInsets.only(top: 20.h),
          ),
        ],
      ),
    );
  }
}
