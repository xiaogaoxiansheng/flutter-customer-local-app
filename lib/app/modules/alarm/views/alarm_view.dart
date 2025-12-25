import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../global_widgets/custom_navbar.dart';
import '../controllers/alarm_controller.dart';
import './alarm_styles.dart';
import '../../main/views/main_styles.dart';

/// 告警页面视图
/// 包含搜索框、状态筛选标签栏和告警列表
class AlarmView extends GetView<AlarmController> {
  const AlarmView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlarmStyles.pageBackground,
      appBar: const CustomNavbar(
        title: '告警',
        showBackButton: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ConstraintLayout(
          children: [
            // 顶部搜索框
            _AlarmSearchBar(controller: controller).applyConstraint(
              id: ConstraintId('search'),
              left: parent.left,
              right: parent.right,
              top: parent.top,
              margin: EdgeInsets.only(top: 12.h),
            ),
            // 状态筛选标签栏
            _AlarmTabs(controller: controller).applyConstraint(
              id: ConstraintId('tabs'),
              left: parent.left,
              right: parent.right,
              top: ConstraintId('search').bottom,
              margin: EdgeInsets.only(top: 16.h),
            ),
            // 告警列表
            _AlarmList(controller: controller).applyConstraint(
              id: ConstraintId('list'),
              left: parent.left,
              right: parent.right,
              top: ConstraintId('tabs').bottom,
              bottom: parent.bottom,
              margin: EdgeInsets.only(top: 150.h),
            ),
          ],
        ),
      ),
    );
  }
}

/// 告警搜索栏组件
/// 用于输入 SN 码或扫描二维码
class _AlarmSearchBar extends StatelessWidget {
  final AlarmController controller;
  const _AlarmSearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      decoration: AlarmStyles.searchDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: ConstraintLayout(
        children: [
          // 搜索图标
          _AlarmAvifIcon(
            assetName: 'assets/images/alarm_search_icon.avif',
            size: 28.w,
            fallbackIcon: Icons.search,
          ).applyConstraint(
            id: ConstraintId('icon'),
            left: parent.left,
            top: parent.top,
            bottom: parent.bottom,
          ),
          // 可编辑输入框，点击即弹出键盘
          TextField(
            controller: controller.searchController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '搜索SN码',
              hintStyle: AlarmStyles.searchHint(context),
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 28.sp, color: AlarmStyles.textPrimary),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            textCapitalization: TextCapitalization.characters,
          ).applyConstraint(
            id: ConstraintId('input'),
            left: ConstraintId('icon').right,
            right: ConstraintId('scan').left,
            top: parent.top,
            bottom: parent.bottom,
            margin: EdgeInsets.only(left: 80.w),
          ),
          // 扫码图标
          GestureDetector(
            onTap: controller.scanBarcode,
            child: Icon(
              Icons.qr_code_scanner,
              size: 30.w,
              color: AlarmStyles.textSecondary,
            ),
          ).applyConstraint(
            id: ConstraintId('scan'),
            right: parent.right,
            top: parent.top,
            bottom: parent.bottom,
          ),
        ],
      ),
    );
  }
}

/// 告警状态筛选标签栏
/// 展示可横向滚动的告警类型选项
class _AlarmTabs extends StatelessWidget {
  final AlarmController controller;
  const _AlarmTabs({required this.controller});

  @override
  Widget build(BuildContext context) {
    final tabs = <_AlarmTabData>[
      const _AlarmTabData(label: '全部'),
      const _AlarmTabData(label: '温度告警', icon: Icons.thermostat),
      const _AlarmTabData(label: '电压告警', icon: Icons.flash_on),
      const _AlarmTabData(label: '电流告警', icon: Icons.electric_bolt),
      const _AlarmTabData(label: '电流告警', icon: Icons.electric_bolt),
      const _AlarmTabData(label: '电流告警', icon: Icons.electric_bolt),
      const _AlarmTabData(label: '电流告警', icon: Icons.electric_bolt),
    ];

    return Obx(
      () {
        final selectedIndex = controller.selectedTabIndex.value;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              tabs.length,
              (index) => Padding(
                padding: EdgeInsets.only(right: 0.w),
                child: _AlarmTab(
                  data: tabs[index],
                  isSelected: selectedIndex == index,
                  onTap: () => controller.selectTab(index),
                  index: index,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 单个筛选标签组件
class _AlarmTab extends StatelessWidget {
  final _AlarmTabData data;
  final bool isSelected;
  final VoidCallback onTap;
  final int index;

  const _AlarmTab({
    required this.data,
    required this.isSelected,
    required this.onTap,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    double leftMargin = index == 0 ? 0 : 16.w;
    final paddingData = data.icon == null
            ? EdgeInsets.symmetric(horizontal: 20.w)
            : EdgeInsets.only(left: 20.w, right: 50.w);
            
    return Container(
      margin: EdgeInsets.only(left: leftMargin),
      child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36.h,
        padding: paddingData,
        decoration: AlarmStyles.tabDecoration(isSelected: isSelected),
        child: ConstraintLayout(
          children: [
            if (data.icon != null)
              Icon(
                data.icon,
                size: 26.w,
                color: isSelected ? Colors.white : AlarmStyles.textPrimary,
              ).applyConstraint(
                id: ConstraintId('icon'),
                left: parent.left,
                top: parent.top,
                bottom: parent.bottom,
              ),
            Text(
              data.label,
              style: AlarmStyles.tabLabel(isSelected: isSelected),
            ).applyConstraint(
              id: ConstraintId('label'),
              left: data.icon == null
                  ? parent.left
                  : ConstraintId('icon').right,
              right: parent.right,
              top: parent.top,
              bottom: parent.bottom,
              margin: EdgeInsets.only(left: data.icon == null ? 0 : 28.w),
            ),
          ],
        ),
      ),
    ),
    );
    
    }
}

/// 告警列表组件
/// 展示告警详细信息列表，支持下拉刷新
class _AlarmList extends StatelessWidget {
  final AlarmController controller;
  const _AlarmList({required this.controller});

  @override
  Widget build(BuildContext context) {
    // 模拟告警数据
    final items = <_AlarmItemData>[
      _AlarmItemData(
        typeLabel: '电压告警',
        typeColor: const Color(0xFFFF9500),
        title: '设备电压过高，当前值2489mV，阈值24.2V',
        sn: 'LD05F23032200001',
        model: 'LD20',
        locationIndex: '1',
        address: '华北-北京-京润粮库-01仓',
        time: '2023-8-9 13:00:00',
      ),
      _AlarmItemData(
        typeLabel: '温度告警',
        typeColor: const Color(0xFFFF9500),
        title: '设备温度过高，当前值80℃，阈值70℃',
        sn: 'LD05F23032200001',
        model: 'LD20',
        locationIndex: '1',
        address: '华北-北京-京润粮库-01仓',
        time: '2023-8-9 13:00:00',
      ),
      _AlarmItemData(
        typeLabel: '电流告警',
        typeColor: const Color(0xFFFF9500),
        title: '设备电流过高，当前值3A，阈值2A',
        sn: 'LD05F23032200001',
        model: 'LD20',
        locationIndex: '1',
        address: '华北-北京-京润粮库-01仓',
        time: '2023-8-9 13:00:00',
      ),
      _AlarmItemData(
        typeLabel: '电流告警',
        typeColor: const Color(0xFFFF9500),
        title: '设备电流过高，当前值3A，阈值2A',
        sn: 'LD05F23032200001',
        model: 'LD20',
        locationIndex: '1',
        address: '华北-北京-京润粮库-01仓',
        time: '2023-8-9 13:00:00',
      ),
      _AlarmItemData(
        typeLabel: '电流告警',
        typeColor: const Color(0xFFFF9500),
        title: '设备电流过高，当前值3A，阈值2A',
        sn: 'LD05F23032200001',
        model: 'LD20',
        locationIndex: '1',
        address: '华北-北京-京润粮库-01仓',
        time: '2023-8-9 13:00:00',
      ),
      _AlarmItemData(
        typeLabel: '电流告警',
        typeColor: const Color(0xFFFF9500),
        title: '设备电流过高，当前值3A，阈值2A',
        sn: 'LD05F23032200001',
        model: 'LD20',
        locationIndex: '1',
        address: '华北-北京-京润粮库-01仓',
        time: '2023-8-9 13:00:00',
      ),
      _AlarmItemData(
        typeLabel: '电流告警',
        typeColor: const Color(0xFFFF9500),
        title: '设备电流过高，当前值3A，阈值2A',
        sn: 'LD05F23032200001',
        model: 'LD20',
        locationIndex: '1',
        address: '华北-北京-京润粮库-01仓',
        time: '2023-8-9 13:00:00',
      ),
    ];

    return RefreshIndicator(
      onRefresh: () => Future<void>.delayed(const Duration(milliseconds: 400)),
      child: ListView.builder(
        padding: EdgeInsets.only(
          // 底部留出导航栏高度，避免被遮挡
          bottom: MainStyles.bottomNavHeight() + 70.h,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => _AlarmListItem(
          data: items[index],
          showTopBorder: true,
        ),
      ),
    );
  }
}

/// 单个告警项组件
/// 展示告警的详细信息，如类型、SN码、位置、时间等
class _AlarmListItem extends StatelessWidget {
  final _AlarmItemData data;
  // 是否显示顶部边框
  final bool showTopBorder;
  const _AlarmListItem({required this.data, this.showTopBorder = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showTopBorder)
          Divider(height: 1.h, color: AlarmStyles.borderLight),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 顶部行：告警类型标签 + 告警标题
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
                    decoration: AlarmStyles.alarmTagDecoration(data.typeColor),
                    child: Text(
                      data.typeLabel,
                      style: AlarmStyles.alarmTagText(data.typeColor),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 0.h),
                      child: Text(
                        data.title,
                        style: AlarmStyles.alarmTitle(context),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              // SN码和型号芯片
              Row(
                children: [
                  _AlarmChip(
                    iconAsset: 'assets/images/alarm_sn.avif',
                    fallbackIcon: Icons.tag,
                    text: data.sn,
                    isColorful: false,
                  ),
                  SizedBox(width: 10.w),
                  _AlarmChip(
                    iconAsset: null,
                    fallbackIcon: Icons.memory,
                    isShowIcon: false,
                    text: data.model,
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              // 位置信息
              _AlarmMetaRow(
                iconAsset: 'assets/images/alarm_location.avif',
                fallbackIcon: Icons.keyboard_arrow_down,
                text: data.locationIndex,
              ),
              SizedBox(height: 4.h),
              // 地址信息
              _AlarmMetaRow(
                iconAsset: 'assets/images/alarm_address.avif',
                fallbackIcon: Icons.place_outlined,
                text: data.address,
              ),
              SizedBox(height: 4.h),
              // 时间信息
              _AlarmMetaRow(
                iconAsset: 'assets/images/alarm_time.avif',
                fallbackIcon: Icons.access_time,
                text: data.time,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 详情芯片组件
/// 用于展示 SN 码、设备型号等简短信息
class _AlarmChip extends StatelessWidget {
  final String? iconAsset;
  final IconData fallbackIcon;
  final String text;
  final bool isColorful;
  final bool isShowIcon;

  const _AlarmChip({
    required this.iconAsset,
    this.fallbackIcon = Icons.tag,
    required this.text,
    this.isColorful = true,
    this.isShowIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final Widget iconWidget = iconAsset != null
        ? _AlarmAvifIcon(
            assetName: iconAsset!,
            size: 28.w,
            fallbackIcon: fallbackIcon,
          )
        : Icon(
            fallbackIcon,
            size: 22.w,
            color: AlarmStyles.textSecondary,
          );

    return Container(
      padding: isColorful ? EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h) : EdgeInsets.zero,
      decoration: isColorful ? AlarmStyles.chipDecoration() : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isShowIcon) ...[
            iconWidget,
            SizedBox(width: 8.w),
          ],
          Text(text, style: AlarmStyles.chipText()),
        ],
      ),
    );
  }
}

/// 元数据行组件
/// 用于展示带图标的详细信息（位置、地址、时间）
class _AlarmMetaRow extends StatelessWidget {
  final String iconAsset;
  final IconData fallbackIcon;
  final String text;

  const _AlarmMetaRow({
    required this.iconAsset,
    required this.fallbackIcon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AlarmAvifIcon(
          assetName: iconAsset,
          size: 26.w,
          fallbackIcon: fallbackIcon,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: AlarmStyles.metaText(),
          ),
        ),
      ],
    );
  }
}

/// Avif 图标组件
/// 加载 Avif 图片失败时显示备用图标
class _AlarmAvifIcon extends StatelessWidget {
  final String assetName;
  final double size;
  final IconData fallbackIcon;

  const _AlarmAvifIcon({
    required this.assetName,
    required this.size,
    required this.fallbackIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AvifImage.asset(
      assetName,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Icon(
        fallbackIcon,
        size: size,
        color: AlarmStyles.textSecondary,
      ),
    );
  }
}

/// 告警筛选标签数据模型
class _AlarmTabData {
  final String label;
  final IconData? icon;

  const _AlarmTabData({
    required this.label,
    this.icon,
  });
}

/// 告警项数据模型
class _AlarmItemData {
  // 告警类型名称
  final String typeLabel;
  // 告警类型颜色
  final Color typeColor;
  // 告警详情标题
  final String title;
  // 设备 SN 码
  final String sn;
  // 设备型号
  final String model;
  // 仓位编号
  final String locationIndex;
  // 详细地址
  final String address;
  // 告警时间
  final String time;

  const _AlarmItemData({
    required this.typeLabel,
    required this.typeColor,
    required this.title,
    required this.sn,
    required this.model,
    required this.locationIndex,
    required this.address,
    required this.time,
  });
}
