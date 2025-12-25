import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 修改密码页控制器
/// 管理输入框状态、校验与提交逻辑
class ModifyPasswordController extends GetxController {
  // 三个输入框控制器
  final TextEditingController oldPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // 密文显示控制
  final isObscureOld = true.obs;
  final isObscureNew = true.obs;
  final isObscureConfirm = true.obs;

  // 加载与错误状态
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  /// 切换旧密码显隐
  void toggleObscureOld() => isObscureOld.value = !isObscureOld.value;

  /// 切换新密码显隐
  void toggleObscureNew() => isObscureNew.value = !isObscureNew.value;

  /// 切换确认密码显隐
  void toggleObscureConfirm() =>
      isObscureConfirm.value = !isObscureConfirm.value;

  /// 提交修改密码
  /// 包含基础校验与模拟提交
  Future<void> submit() async {
    errorMessage.value = '';
    final old = oldPasswordController.text.trim();
    final newPwd = newPasswordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (old.isEmpty || newPwd.isEmpty || confirm.isEmpty) {
      errorMessage.value = '请输入完整的密码信息';
      return;
    }
    if (newPwd.length < 6) {
      errorMessage.value = '新密码长度不少于 6 位';
      return;
    }
    if (newPwd != confirm) {
      errorMessage.value = '两次输入的新密码不一致';
      return;
    }

    isLoading.value = true;
    try {
      // TODO: 在此处调用后端接口完成密码修改
      // 这里进行简化为模拟网络请求
      await Future.delayed(const Duration(milliseconds: 800));
      // 修改成功后返回上一页
      Get.back();
    } catch (e) {
      errorMessage.value = '修改失败，请稍后重试';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

