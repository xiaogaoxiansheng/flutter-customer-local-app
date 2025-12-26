import 'package:flutter/material.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

import '../../../global_widgets/custom_navbar.dart';
import '../controllers/device_controller.dart';
import './device_styles.dart';

/// 顶部操作栏组件
/// 提供开/关Led、拍照等操作
class _ActionBar extends GetView<DeviceController> {
  const _ActionBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionButton(
          icon: Icons.lightbulb_outline,
          label: '开Led',
          bg: const Color(0xFFE8F6EE),
          color: DeviceStyles.primaryGreen,
          onTap: controller.openLedAll,
        ),
        SizedBox(width: 12.w),
        _ActionButton(
          icon: Icons.lightbulb,
          label: '关Led',
          bg: const Color(0xFFFDEDEE),
          color: const Color(0xFFFF4D4F),
          onTap: controller.closeLedAll,
        ),
        SizedBox(width: 12.w),
        _ActionButton(
          icon: Icons.photo_camera,
          label: '拍照',
          bg: const Color(0xFFE9F2FF),
          color: const Color(0xFF3B82F6),
          onTap: controller.takePhoto,
        ),
        SizedBox(width: 12.w),
        _ActionButton(
          icon: Icons.more_horiz,
          label: '更多',
          bg: DeviceStyles.disabledGray,
          color: const Color(0xFF9AA0A6),
          onTap: null,
        ),
      ],
    );
  }
}

/// 设备页视图
/// 按截图布局：位置与统计、操作栏、设备列表
class DeviceView extends GetView<DeviceController> {
  const DeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DeviceStyles.pageBackground,
      appBar: const CustomNavbar(title: '设备', showBackButton: false),
      // 页面左右内边距（适配设计稿整体留白）
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ConstraintLayout(
        children: [
          // 顶部位置文本
          Obx(() => Row(
                children: [
                  Text(
                    controller.locationText.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: DeviceStyles.locationText(context),
                  ),
                  Icon(Icons.arrow_drop_down, color: DeviceStyles.textSecondary,
                      size: 30.w),
                ],
              )).applyConstraint(
            id: ConstraintId('loc'),
            left: parent.left,
            right: parent.right,
            top: parent.top,
            margin: EdgeInsets.only(top: 12.h),
          ),

          // 顶部统计 + 位置图按钮
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
            child: Row(
              children: [
                Obx(() {
                  final online =
                      controller.items.where((e) => e.ledOn).length;
                  return Row(
                    children: [
                      SizedBox(width: 24.w),
                      Text(
                        '$online',
                        style: DeviceStyles.statisticNumber(true),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: Text(
                          '在线',
                          style: DeviceStyles.statisticLabelOnline(),
                        ),
                      ),
                      SizedBox(width: 70.w),
                    ],
                  );
                }),
                DeviceStyles.statVerticalDivider(),
                Obx(() {
                  final offline =
                      controller.items.where((e) => !e.ledOn).length;
                  return Row(
                    children: [
                      Text(
                        '$offline',
                        style: DeviceStyles.statisticNumber(false),
                      ),
                      SizedBox(width: 6.w),
                      Container(
                        margin: EdgeInsets.only(top: 8.h),
                        child: Text(
                          '离线',
                          style: DeviceStyles.statisticLabelOffline(),
                        ),
                      ),
                    ],
                  );
                }),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: DeviceStyles.positionButtonDecoration(),
                    child: Row(
                      children: [
                        Container(
                          width: 22.w,
                          height: 22.w,
                          decoration: const BoxDecoration(
                            color: DeviceStyles.primaryGreen,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 14.w,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '设备位置图',
                          style: DeviceStyles.positionButtonText(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).applyConstraint(
            id: ConstraintId('stat'),
            left: parent.left,
            right: parent.right,
            top: ConstraintId('loc').bottom,
          ),

          // 顶部分割线
          DeviceStyles.topDivider().applyConstraint(
            id: ConstraintId('divider'),
            left: parent.left,
            right: parent.right,
            top: ConstraintId('stat').bottom,
            margin: EdgeInsets.only(top: 12.h),
          ),

          // 操作按钮栏：开/关Led、拍照、占位
          _ActionBar().applyConstraint(
            id: ConstraintId('actions'),
            left: parent.left,
            right: parent.right,
            top: ConstraintId('divider').bottom,
            margin: EdgeInsets.only(top: 16.h),
          ),

          // 列表
          Container(
            color: Colors.transparent, // 确保有绘制区域
            child: Obx(() => ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) => _DeviceItemTile(
                    item: controller.items[index],
                  ),
                )),
          ).applyConstraint(
            id: ConstraintId('list'),
            left: parent.left,
            right: parent.right,
            top: ConstraintId('actions').bottom,
            bottom: parent.bottom,
            margin: EdgeInsets.only(top: 16.h),
            height: matchConstraint, // 关键：告诉 ConstraintLayout 填充剩余空间
          ),
        ],
      ),
      ),
    );
}
}

/// 操作按钮子组件
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bg;
  final Color color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.bg,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40.h,
          decoration: DeviceStyles.actionButtonDecoration(bg),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 22.w),
              SizedBox(width: 6.w),
              Text(label, style: DeviceStyles.actionText(context, color)),
            ],
          ),
        ),
      ),
    );
  }
}

/// 设备列表项组件
/// 包含主图、型号标签、ID、方向、LED 状态、告警与病虫标签
class _DeviceItemTile extends StatelessWidget {
  final DeviceItem item;
  const _DeviceItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: ConstraintLayout(
        children: [
          // 左侧主图
          ClipRRect(
            borderRadius: BorderRadius.circular(999.r),
            child: Image.network(
              DeviceController.imageUrl,
              width: 130.w,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Icon(Icons.devices_other,
                  size: 48.w, color: DeviceStyles.textSecondary),
            ),
          ).applyConstraint(
            id: ConstraintId('img'),
            left: parent.left,
            top: parent.top,
          ),

          // 主图上的病虫标签
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: DeviceStyles.bugBadgeDecoration(!item.hasBug),
            alignment: Alignment.center,
            height: 16.h,
            child: Builder(builder: (context) {
              final text = item.hasBug ? '有虫虫虫虫虫虫' : '无虫';
              if (text.length > 3) {
                return Marquee(
                  text: text,
                  style: DeviceStyles.bugBadgeText(context),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  blankSpace: 20.0,
                  velocity: 30.0,
                  startPadding: 10.0,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                );
              }
              return Text(
                text,
                style: DeviceStyles.bugBadgeText(context),
                textAlign: TextAlign.center,
              );
            }),
          ).applyConstraint(
            id: ConstraintId('bug'),
            left: ConstraintId('img').left,
            right: ConstraintId('img').right,
            bottom: ConstraintId('img').bottom,
            width: 80.w,
          ),

          // 型号灰标签
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: DeviceStyles.modelChipDecoration(),
            child: Text(item.model, style: DeviceStyles.modelChipText(context)),
          ).applyConstraint(
            id: ConstraintId('chip'),
            left: ConstraintId('img').right,
            top: parent.top,
            margin: EdgeInsets.only(left: 12.w),
          ),

          // 设备 ID
          Text(item.id, style: DeviceStyles.deviceIdText(context))
              .applyConstraint(
            id: ConstraintId('id'),
            left: ConstraintId('chip').right,
            top: parent.top,
            margin: EdgeInsets.only(left: 8.w),
          ),

          // 第二行：方向
          Row(
            children: [
              Icon(Icons.south, size: 18.w, color: DeviceStyles.textSecondary),
              SizedBox(width: 4.w),
              Text(item.direction, style: DeviceStyles.directionText(context)),
            ],
          ).applyConstraint(
            id: ConstraintId('meta'),
            left: ConstraintId('img').right,
            top: ConstraintId('id').bottom,
            margin: EdgeInsets.only(left: 12.w, top: 6.h),
          ),

          // 第三行：LED 状态 与 告警
          Row(
            children: [
              SizedBox(width: 12.w),
              Text(
                item.ledOn ? 'Led开启' : 'Led关闭',
                style: item.ledOn
                    ? DeviceStyles.ledOnText(context)
                    : DeviceStyles.ledOffText(context),
              ),
              SizedBox(width: 12.w),
              Text('${item.alarmCount}条告警',
                  style: DeviceStyles.alarmText(context)),
            ],
          ).applyConstraint(
            id: ConstraintId('meta2'),
            left: ConstraintId('img').right,
            top: ConstraintId('meta').bottom,
            margin: EdgeInsets.only(left: 2.w, top: 6.h),
          ),

          // 右侧箭头
          Icon(Icons.chevron_right, size: 42.w, color: const Color(0xFFCCCCCC))
              .applyConstraint(
            id: ConstraintId('arrow'),
            right: parent.right,
            top: ConstraintId('img').top,
            margin: EdgeInsets.only(top: 32.h),
          ),
        ],
      ),
    );
  }
}
