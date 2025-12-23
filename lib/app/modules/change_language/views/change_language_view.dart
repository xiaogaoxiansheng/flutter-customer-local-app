import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import './change_language_styles.dart';
import '../controllers/change_language_controller.dart';

class ChangeLanguageView extends GetView<ChangeLanguageController> {
  const ChangeLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AvifImage.asset(
              'assets/images/other_home_bg.avif',
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => const SizedBox.shrink(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: ConstraintLayout(
                children: [
                  Text(
                    '选择语言',
                    style: ChangeLanguageStyles.title(context),
                  ).applyConstraint(
                    id: ConstraintId('title'),
                    left: parent.left,
                    top: parent.top,
                    margin: EdgeInsets.only(top: 200.h),
                  ),
                  Text(
                    'language',
                    style: ChangeLanguageStyles.subtitle(context),
                  ).applyConstraint(
                    id: ConstraintId('subtitle'),
                    left: parent.left,
                    top: ConstraintId('title').bottom,
                    margin: EdgeInsets.only(top: 4.h),
                  ),
                  Obx(
                    () {
                      final isZh = controller.selectedLocale.value.languageCode == 'zh';
                      return _LanguageItem(
                        label: '中文',
                        selected: isZh,
                        onTap: controller.selectChinese,
                      ).applyConstraint(
                        id: ConstraintId('zh'),
                        left: parent.left,
                        right: parent.right,
                        top: ConstraintId('subtitle').bottom,
                        margin: EdgeInsets.only(top: 90.h),
                      );
                    },
                  ),
                  Obx(
                    () {
                      final isEn = controller.selectedLocale.value.languageCode == 'en';
                      return _LanguageItem(
                        label: 'English',
                        selected: isEn,
                        onTap: controller.selectEnglish,
                      ).applyConstraint(
                        id: ConstraintId('en'),
                        left: parent.left,
                        right: parent.right,
                        top: ConstraintId('zh').bottom,
                        margin: EdgeInsets.only(top: 12.h),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: controller.confirm,
                    child: Container(
                      height: 48.h,
                      decoration:
                          ChangeLanguageStyles.confirmButtonDecoration(),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ).applyConstraint(
                    id: ConstraintId('confirm'),
                    left: parent.left,
                    right: parent.right,
                    top: ConstraintId('en').bottom,
                    margin: EdgeInsets.only(top: 40.h),
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

class _LanguageItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: ChangeLanguageStyles.languageBorder(selected),
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Text(
          label,
          style: ChangeLanguageStyles.languageLabel(selected),
        ),
      ),
    );
  }
}
