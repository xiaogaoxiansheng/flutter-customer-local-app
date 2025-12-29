import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../global_widgets/custom_navbar.dart';
import '../controllers/device_details_controller.dart';
import './device_details_styles.dart';

/// 设备详情页
/// 按截图还原：顶部信息卡片、功能入口、图库/虫情/传感器等分区
class DeviceDetailsView extends GetView<DeviceDetailsController> {
  const DeviceDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DeviceDetailsStyles.pageBackground,

      /// 顶部导航栏（复用已封装组件）
      appBar: CustomNavbar(
        title: '设备详情',
      ),

      /// 页面主体：整页可滚动
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          /// 顶部设备信息卡片
          SliverToBoxAdapter(
            child: Padding(
              padding: DeviceDetailsStyles.headerCardMargin(),
              child: const _DeviceHeaderCard(),
            ),
          ),

          /// 功能入口栏
          SliverToBoxAdapter(
            child: Padding(
              padding: DeviceDetailsStyles.pagePadding(),
              child: const _ActionTilesRow(),
            ),
          ),
          

          /// 基础信息区
          SliverToBoxAdapter(
            child: Padding(
              padding: DeviceDetailsStyles.pagePadding(),
              child: const _DeviceBaseInfoCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 16.h),
          ),

          /// 图库分区
          SliverToBoxAdapter(
            child: Padding(
              padding: DeviceDetailsStyles.pagePadding(),
              child: const _GalleryCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 16.h),
          ),

          /// 虫情分区（标题与图标移动到卡片内部）
          SliverToBoxAdapter(
            child: Padding(
              padding: DeviceDetailsStyles.pagePadding(),
              child: const _InsectSummaryCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 16.h),
          ),

          /// 传感器分区（标题与图标移动到卡片内部）
          const _SensorListSliver(),

          /// 告警分区
          SliverToBoxAdapter(
            child: SizedBox(height: 16.h),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: DeviceDetailsStyles.pagePadding(),
              child: const _AlarmCard(),
            ),
          ),

          /// 工作时间分区
          SliverToBoxAdapter(
            child: SizedBox(height: 16.h),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: DeviceDetailsStyles.pagePadding(),
              child: const _WorkTimeCard(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 32.h),
          ),
        ],
      ),
    );
  }
}

/// 顶部设备信息卡片
class _DeviceHeaderCard extends GetView<DeviceDetailsController> {
  const _DeviceHeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DeviceDetailsStyles.cardDecoration(),
      padding: EdgeInsets.only(left: 20.w),
      child: SizedBox(
        height: 220.h,
        child: ClipRRect(
          borderRadius: DeviceDetailsStyles.cardRadius(),
          child: ConstraintLayout(
            children: [
              AvifImage.asset(
                'assets/images/device_bg.avif',
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
              ).applyConstraint(
                id: ConstraintId('bg'),
                right: parent.right,
                top: parent.top,
                bottom: parent.bottom,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 34.h,
                ),
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          Text(
                            controller.deviceId.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: DeviceDetailsStyles.deviceIdText(context),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                            ),
                            decoration:
                                DeviceDetailsStyles.modelChipDecoration(),
                            child: Text(
                              controller.modelText.value,
                              style:
                                  DeviceDetailsStyles.modelChipText(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    const _StatusGrid(),
                    SizedBox(height: 16.h),
                    const _CaptureStrength(),
                  ],
                ),
              ).applyConstraint(
                id: ConstraintId('content'),
                left: parent.left,
                top: parent.top,
                bottom: parent.bottom,
                right: parent.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 在线/工作状态区域
class _StatusGrid extends GetView<DeviceDetailsController> {
  const _StatusGrid();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// 在线状态
        Obx(
          () => _StatusItem(
            title: '在线状态',
            value: controller.onlineStatusText.value,
            icon: Icons.wifi,
            iconColor: DeviceDetailsStyles.primaryGreen,
          ),
        ),
        SizedBox(width: 24.w),

        /// 工作状态
        Obx(
          () => _StatusItem(
            title: '工作状态',
            value: controller.workStatusText.value,
            icon: Icons.play_circle_fill,
            iconColor: DeviceDetailsStyles.primaryGreen,
          ),
        ),
      ],
    );
  }
}

/// 诱捕强度
class _CaptureStrength extends GetView<DeviceDetailsController> {
  const _CaptureStrength();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            '诱捕强度  ${controller.captureStrengthText.value}',
            style: DeviceDetailsStyles.metaText(context),
          ),
        ),
        Obx(
          () => Text(
            '亮度  ${controller.brightnessText.value} 光模组功耗 ${controller.brightnessText.value}',
            style: DeviceDetailsStyles.metaText(context),
          ),
        ),
      ],
    );
  }
}

/// 单个状态项
class _StatusItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _StatusItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: DeviceDetailsStyles.statusTitleText(context)),
        SizedBox(height: 6.h),
        Row(
          children: [
            Text(value, style: DeviceDetailsStyles.statusValueText(context)),
            SizedBox(width: 6.w),
            Icon(icon, size: 24.w, color: iconColor),
          ],
        ),
      ],
    );
  }
}

class _ActionTilesRow extends StatelessWidget {
  const _ActionTilesRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DeviceDetailsStyles.cardDecoration(),
      height: 100.h,
      padding: EdgeInsets.only(bottom: 12.h),
      child: SizedBox(
     
      child: Row(
        children: [
          Expanded(
            child: _ActionTile(
              icon: Icons.lightbulb_outline,
              title: 'LED',
              subtitle: '开',
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _ActionTile(
              icon: Icons.photo_camera_outlined,
              title: '拍照',
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _ActionTile(
              icon: Icons.blur_on,
              title: '重启',
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _ActionTile(
              icon: Icons.refresh,
              title: '刷新',
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _ActionTile(
              icon: Icons.notifications_active_outlined,
              title: '蜂鸣',
            ),
          ),
        ],
      ),
    ),
      );
    }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const _ActionTile({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DeviceDetailsStyles.actionTileDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28.w,
            color: DeviceDetailsStyles.primaryGreen,
          ),
          SizedBox(height: 6.h),
          if (subtitle == null)
            Text(
              title,
              style: DeviceDetailsStyles.actionTileText(context),
            )
          else
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: DeviceDetailsStyles.actionTileText(context),
                ),
                Text(
                  subtitle!,
                  style: DeviceDetailsStyles.actionTileText(context),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

/// 基础信息卡片（位置/设备名等）
class _DeviceBaseInfoCard extends GetView<DeviceDetailsController> {
  const _DeviceBaseInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DeviceDetailsStyles.infoCardDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 顶部小入口（模拟“查看/修改打位”）
          Row(
            children: [
              AvifImage.asset(
                'assets/images/alarm_location.avif',
                width: 24.w,
                height: 24.w,
              ),
              SizedBox(width: 6.w),
              Text('4', style: DeviceDetailsStyles.sectionActionText(context)),
              const Spacer(),
              Text(
                '查看  修改打位',
                style: DeviceDetailsStyles.sectionActionText(context),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          /// 位置信息
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AvifImage.asset(
                'assets/images/alarm_address.avif',
                width: 24.w,
                height: 24.w,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Obx(
                  () => Text(
                    controller.locationText.value,
                    style: DeviceDetailsStyles.metaText(context),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          /// 设备别名/SN
          Row(
            children: [
              AvifImage.asset(
                'assets/images/alarm_sn.avif',
                width: 24.w,
                height: 24.w,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Obx(
                  () => Text(
                    controller.deviceNameText.value,
                    style: DeviceDetailsStyles.metaText(context),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



/// 图库卡片（预览 + AI 识别结果）
class _GalleryCard extends GetView<DeviceDetailsController> {
  const _GalleryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DeviceDetailsStyles.cardDecoration(),
      padding: EdgeInsets.all(16.w),
      child: ConstraintLayout(
        children: [
          /// 左上角“图库”标题与图标（移动到白色卡片内部）
          Row(
            children: [
              Icon(
                Icons.photo_library_outlined,
                size: 26.w,
                color: DeviceDetailsStyles.textSecondary,
              ),
              SizedBox(width: 8.w),
              Text(
                '图库',
                style: DeviceDetailsStyles.sectionTitleText(context),
              ),
            ],
          ).applyConstraint(
            id: ConstraintId('header'),
            left: parent.left,
            top: parent.top,
          ),
          /// 右上角“更多 >”入口（移动到白色卡片内部）
          /// 说明：保持原有样式，仅改变位置到卡片右上角
          Text(
            '更多 >',
            style: DeviceDetailsStyles.sectionActionText(context),
          ).applyConstraint(
            id: ConstraintId('more'),
            right: parent.right,
            top: parent.top,
          ),
          /// 左侧预览图占位
          Container(
            height: 130.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: const Color(0xFFEEF2F6),
            ),
            child: Center(
              child: Icon(
                Icons.camera_outlined,
                size: 48.w,
                color: DeviceDetailsStyles.textSecondary,
              ),
            ),
          ).applyConstraint(
            id: ConstraintId('img'),
            left: parent.left,
            top: ConstraintId('header').bottom,
            width: 400.w,
            margin: EdgeInsets.only(top: 12.h),
          ),

          /// 右侧信息区
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// AI 识别标签
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: DeviceDetailsStyles.aiChipDecoration(),
                child: Text('AI识别', style: DeviceDetailsStyles.aiChipText(context)),
              ),
              SizedBox(height: 10.h),

              /// 实时虫量
              Obx(
                () => Text(
                  '实时虫量  ${controller.aiInsectCountText.value}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: DeviceDetailsStyles.sensorNameText(context),
                ),
              ),
              SizedBox(height: 10.h),

              /// 虫口密度
              Obx(
                () => Row(
                  children: [
                    Text(
                      '虫口密度  ',
                      style: DeviceDetailsStyles.sensorValueText(context),
                    ),
                    Text(
                      controller.insectDensityText.value,
                      style: controller.insectDensityText.value.contains('无')
                          ? DeviceDetailsStyles.warnText(context)
                              .copyWith(color: DeviceDetailsStyles.primaryGreen)
                          : DeviceDetailsStyles.warnText(context),
                    ),
                  ],
                ),
              ),
            ],
          ).applyConstraint(
            id: ConstraintId('info'),
            left: ConstraintId('img').right,
            top: ConstraintId('header').bottom,
            margin: EdgeInsets.only(left: 50.w, top: 14.h),
          ),
        ],
      ),
    );
  }
}

/// 虫情概览卡片
class _InsectSummaryCard extends GetView<DeviceDetailsController> {
  const _InsectSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DeviceDetailsStyles.cardDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 左上角“虫情”标题与图标（移动到白色卡片内部）
          Row(
            children: [
              Icon(
                Icons.bug_report_outlined,
                size: 26.w,
                color: DeviceDetailsStyles.textSecondary,
              ),
              SizedBox(width: 8.w),
              Text('虫情',
                  style: DeviceDetailsStyles.sectionTitleText(context)),
            ],
          ),
          SizedBox(height: 12.h),

          /// 指标行（去掉中间竖线）
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => _MetricBlock(
                    valueText: controller.weeklyInsectCountText.value,
                    labelText: '近一周总虫量增长',
                  ),
                ),
              ),
              SizedBox(width: 0.w),
              Expanded(
                child: Obx(
                  () => _MetricBlock(
                    valueText: controller.weeklyIncreaseText.value,
                    labelText: '近一周虫量增速',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 虫情统计块
class _MetricBlock extends StatelessWidget {
  final String valueText;
  final String labelText;

  const _MetricBlock({
    required this.valueText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          valueText,
          style: DeviceDetailsStyles.deviceIdText(context).copyWith(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: DeviceDetailsStyles.textSecondary,
              ),
        ),
        SizedBox(height: 8.h),
        Text(
          labelText,
          style: DeviceDetailsStyles.sectionActionText(context),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// 传感器列表 Sliver
class _SensorListSliver extends GetView<DeviceDetailsController> {
  const _SensorListSliver();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: DeviceDetailsStyles.pagePadding(),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: DeviceDetailsStyles.cardDecoration(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 左上角“传感器”标题与图标
              Row(
                children: [
                  Icon(
                    Icons.sensors_outlined,
                    size: 26.w,
                    color: DeviceDetailsStyles.textSecondary,
                  ),
                  SizedBox(width: 8.w),
                  Text('传感器',
                      style: DeviceDetailsStyles.sectionTitleText(context)),
                ],
              ),
              SizedBox(height: 12.h),

              /// 传感器列表（双列布局）
              Obx(() {
                if (controller.isInitialLoading.value) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: DeviceDetailsStyles.primaryGreen,
                      ),
                    ),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 40.h,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 0.h,
                  ),
                  itemCount: controller.sensors.length,
                  itemBuilder: (context, index) {
                    final item = controller.sensors[index];
                    return _SensorTile(item: item);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

/// 传感器条目（Grid Item）
class _SensorTile extends StatelessWidget {
  final DeviceSensorItem item;

  const _SensorTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            '${item.name}: ${item.valueText}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: DeviceDetailsStyles.sensorNameText(context),
          ),
        ),
        SizedBox(width: 6.w),
        /// 离线标签（模拟）
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          decoration: DeviceDetailsStyles.sensorOfflineDecoration(),
          child: Text(
            '离线',
            style: DeviceDetailsStyles.sensorOfflineText(context),
          ),
        ),
      ],
    );
  }
}

/// 告警卡片
class _AlarmCard extends GetView<DeviceDetailsController> {
  const _AlarmCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DeviceDetailsStyles.cardDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 标题行
          Row(
            children: [
              Icon(Icons.notifications_none,
                  size: 26.w, color: DeviceDetailsStyles.textSecondary),
              SizedBox(width: 8.w),
              Text('设备告警', style: DeviceDetailsStyles.sectionTitleText(context)),
              const Spacer(),
              Obx(
                () => Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF2F6),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: Text(
                    controller.alarmCountText.value,
                    style: DeviceDetailsStyles.sectionActionText(context),
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Icon(Icons.chevron_right,
                  size: 26.w, color: DeviceDetailsStyles.textSecondary),
            ],
          ),
          /// 告警列表
          SizedBox(height: 10.h),
          Obx(() {
            if (controller.alarms.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Center(
                  child: Text('暂无告警',
                      style: DeviceDetailsStyles.sectionActionText(context)),
                ),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.alarms.length,
              separatorBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: DeviceDetailsStyles.divider(),
              ),
              itemBuilder: (context, index) {
                final alarm = controller.alarms[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 告警标签
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: DeviceDetailsStyles.alarmTagDecoration(),
                      child: Text(
                        alarm.tag,
                        style: DeviceDetailsStyles.alarmTagText(context),
                      ),
                    ),
                    SizedBox(width: 10.w),

                    /// 告警内容
                    Expanded(
                      child: Text(
                        alarm.content,
                        style: DeviceDetailsStyles.alarmContentText(context),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 10.w),

                    /// 告警时间
                    Text(
                      alarm.time,
                      style: DeviceDetailsStyles.alarmTimeText(context),
                    ),
                  ],
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

/// 工作时间卡片
class _WorkTimeCard extends GetView<DeviceDetailsController> {
  const _WorkTimeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DeviceDetailsStyles.cardDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 标题行
          Row(
            children: [
              Icon(Icons.access_time,
                  size: 26.w, color: DeviceDetailsStyles.textSecondary),
              SizedBox(width: 8.w),
              Text('工作时间', style: DeviceDetailsStyles.sectionTitleText(context)),
            ],
          ),
          SizedBox(height: 12.h),
          Obx(
            () => Text(
              controller.workTimeText.value,
              style: DeviceDetailsStyles.deviceIdText(context).copyWith(
                fontSize: 26.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
