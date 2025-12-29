import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_constraintlayout/flutter_constraintlayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import './home_styles.dart';

/// 首页（粮仓详情列表页）
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeStyles.primaryGreen,
      body: const _HomeContent(),
    );
  }
}

/// 顶部背景区
class _HomeBackground extends StatelessWidget {
  const _HomeBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      // 顶部使用渐变背景，自适应高度，避免与下方内容出现大块空白
      decoration: HomeStyles.headerDecoration(),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Opacity(
              opacity: 0.18,
              child: AvifImage.asset(
                'assets/images/other_home_bg.avif',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (c, e, s) => const SizedBox.shrink(),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: HomeStyles.headerPadding(),
              child: ConstraintLayout(
                children: [
                  // 左侧系统标题区域
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '多参数粮情智能AI监测系统',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: HomeStyles.headerTitle(context),
                      ),
                      Text(
                        '中科芯禾&成都储藏院',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: HomeStyles.headerSubtitle(context),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ).applyConstraint(
                    id: ConstraintId('title'),
                    left: parent.left,
                    top: parent.top,
                    margin: EdgeInsets.only(top: 50.h),
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

/// 首页内容区域
/// 承载库点位置、在线汇总卡片以及粮仓列表
class _HomeContent extends GetView<HomeController> {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: HomeStyles.contentContainerDecoration(),
      child: RefreshIndicator(
        color: HomeStyles.primaryGreen,
        onRefresh: controller.refresh,
        child: CustomScrollView(
          controller: controller.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _HomeBackground(),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: HomeStyles.sectionMargin(),
                child: const _LocationRow(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(32.w, 14.h, 32.w, 0),
                child: const _SummaryCard(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: HomeStyles.sectionMargin(),
                child: const _SectionHeader(),
              ),
            ),
            Obx(() {
              if (controller.isInitialLoading.value) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: HomeStyles.primaryGreen,
                    ),
                  ),
                );
              }

              final items = controller.items;
              if (items.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      '暂无粮仓数据',
                      style: HomeStyles.onlineLabel(context),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: HomeStyles.listPadding(),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = items[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: _GranaryCard(item: item),
                      );
                    },
                    childCount: items.length,
                  ),
                ),
              );
            }),
            Obx(() {
              if (controller.isLoadingMore.value) {
                return SliverToBoxAdapter(
                  child: Center(
                      child: Text(
                        '正在加载...',
                        style: HomeStyles.loadingMoreText(context),
                      ),
                    ),
                );
              }

              if (!controller.hasMore.value &&
                  controller.items.isNotEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                      child: Text(
                        '没有更多了',
                        style: HomeStyles.loadingMoreText(context),
                      ),
                    ),
                );
              }

              return SliverToBoxAdapter(
                child: SizedBox(height: 24.h),
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// 顶部库点位置行
/// 展示当前库点名称与位置图标
class _LocationRow extends GetView<HomeController> {
  const _LocationRow();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: Text(
              controller.warehouseName.value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              // 使用更贴合位置展示的样式，使层级更清晰
              style: HomeStyles.locationText(context),
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: HomeStyles.textSecondary,
            size: 32.w,
          ),
        ],
      ),
    );
  }
}

/// 顶部在线汇总卡片
/// 显示在线/全部数量与三条关键指标
class _SummaryCard extends GetView<HomeController> {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            child: Obx(() {
              final online = controller.onlineCount.value;
              final total = controller.totalCount.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$online',
                        style: HomeStyles.onlineNumber(context),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '/$total',
                        style: HomeStyles.onlineLabel(context).copyWith(
                              color: HomeStyles.textPrimary,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '在线/全部',
                    style: HomeStyles.onlineLabel(context),
                  ),
                ],
              );
            }),
          ),
          HomeStyles.summaryDivider(),
          SizedBox(width:10.h),
          Expanded(
            child: Obx(
              () {
                final metrics = controller.topMetrics;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final metric in metrics)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Text(
                          '${metric.label}  ${metric.valueText}',
                          style: HomeStyles.metricLabelStyle(
                            context,
                            metric.color,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 粮仓详情分区标题
/// 对应截图中的“粮仓详情”一行
class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.grain,
          color: HomeStyles.primaryGreen,
          size: 32.w,
        ),
        SizedBox(width: 8.w),
        Text(
          '粮仓详情',
          style: HomeStyles.sectionTitle(context),
        ),
      ],
    );
  }
}

/// 粮仓列表卡片
/// 包含顶部彩色背景与下方指标信息
class _GranaryCard extends StatelessWidget {
  final HomeGranaryItem item;

  const _GranaryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: HomeStyles.cardDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _GranaryCardHeader(item: item),
          _GranaryCardBody(item: item),
        ],
      ),
    );
  }
}

/// 粮仓卡片顶部区域
/// 显示仓库编号、更新时间，背景为粮仓主题图片
class _GranaryCardHeader extends StatelessWidget {
  final HomeGranaryItem item;

  const _GranaryCardHeader({required this.item});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: HomeStyles.cardHeaderRadius(),
      child: Container(
        // 高度由内部文字和内边距自然撑开
        width: double.infinity,
        color: Colors.transparent,
        child: Stack(
          children: [
            // 背景图片：与父容器之间保留一定内边距，并单独做圆角裁剪
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: ClipRRect(
                  borderRadius: HomeStyles.cardInnerHeaderRadius(),
                  child: AvifImage.asset(
                    HomeStyles.cardHeaderBackgroundAsset(item.level),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            // 轻微蒙层，保证文字对比度
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.02),
              ),
            ),
            // 左侧标题与更新时间文案
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 16.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.idText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: HomeStyles.cardIdText(context),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '更新时间：${item.updatedAtText}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: HomeStyles.cardUpdateText(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 粮仓卡片底部指标区域
/// 以两列形式展示温度、湿度、CO2 与虫情
class _GranaryCardBody extends StatelessWidget {
  final HomeGranaryItem item;

  const _GranaryCardBody({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: HomeStyles.cardBodyPadding(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 第一行：最高温度 | 最高湿度
          Row(
            children: [
              Expanded(
                child: _GranaryMetricRow(
                  label: '最高温度',
                  value: item.averageBugText,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '|',
                style: HomeStyles.cardMetricLabel(context),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _GranaryMetricRow(
                  label: '最高湿度',
                  value: item.averageHumidityText,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // 第二行：最高CO2 | 虫口密度（最新虫量）
          Row(
            children: [
              Expanded(
                child: _GranaryMetricRow(
                  label: '最高CO2',
                  value: item.averageCo2Text,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '|',
                style: HomeStyles.cardMetricLabel(context),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _GranaryMetricRow(
                  label: '虫口密度',
                  value: item.bugStatusText,
                  valueColor: item.bugStatusText.contains('无')
                      ? HomeStyles.primaryGreen
                      : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 粮仓指标行组件
/// 左侧为指标名称，右侧为具体数值
class _GranaryMetricRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _GranaryMetricRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: HomeStyles.cardMetricLabel(context),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: HomeStyles.cardMetricValue(
              context,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}
