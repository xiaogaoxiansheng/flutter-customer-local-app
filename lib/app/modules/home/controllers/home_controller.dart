import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  /// 当前库点名称
  final warehouseName = '北京中储粮八达岭库'.obs;

  /// 在线/全部
  final onlineCount = 21.obs;
  final totalCount = 25.obs;

  /// 顶部三行指标
  final topMetrics = <HomeTopMetric>[
    const HomeTopMetric(
      label: '最高温度',
      valueText: '24℃',
      granaryText: '粮仓3号',
      color: Color(0xFF2DB84D),
    ),
    const HomeTopMetric(
      label: '最高湿度',
      valueText: '14%',
      granaryText: '粮仓3号',
      color: Color(0xFF2D7CFF),
    ),
    const HomeTopMetric(
      label: '最高CO2',
      valueText: '11%',
      granaryText: '粮仓5号',
      color: Color(0xFFFFA000),
    ),
  ].obs;

  /// 粮仓详情列表
  final items = <HomeGranaryItem>[].obs;

  /// 列表滚动控制器（触底分页）
  final scrollController = ScrollController();

  /// 首次加载状态
  final isInitialLoading = true.obs;

  /// 触底加载状态
  final isLoadingMore = false.obs;

  /// 是否还有下一页
  final hasMore = true.obs;

  int _page = 1;

  @override
  void onInit() {
    super.onInit();
    _loadInitial();
    scrollController.addListener(_handleScroll);
  }

  @override
  void onClose() {
    scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.onClose();
  }

  /// 下拉刷新入口
  /// 对外提供刷新方法，内部复用首次加载逻辑
  @override
  Future<void> refresh() => _loadInitial();

  /// 首次加载列表数据
  Future<void> _loadInitial() async {
    isInitialLoading.value = true;
    _page = 1;
    hasMore.value = true;
    items.clear();
    final data = await _fetchPage(_page);
    items.assignAll(data);
    isInitialLoading.value = false;
  }

  /// 监听滚动，接近底部时触发加载下一页
  void _handleScroll() {
    if (!scrollController.hasClients) return;
    final position = scrollController.position;
    if (position.maxScrollExtent <= 0) return;

    final isNearBottom =
        position.pixels >= position.maxScrollExtent - 200.0;
    if (!isNearBottom) return;
    _loadMore();
  }

  /// 触底加载下一页
  Future<void> _loadMore() async {
    if (isInitialLoading.value) return;
    if (isLoadingMore.value) return;
    if (!hasMore.value) return;

    isLoadingMore.value = true;
    final nextPage = _page + 1;
    final data = await _fetchPage(nextPage);
    if (data.isEmpty) {
      hasMore.value = false;
      isLoadingMore.value = false;
      return;
    }

    _page = nextPage;
    items.addAll(data);
    isLoadingMore.value = false;
  }

  /// 模拟分页数据（后续可替换为接口请求）
  Future<List<HomeGranaryItem>> _fetchPage(int page) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    if (page > 3) return [];

    final baseIndex = (page - 1) * 10;
    return List<HomeGranaryItem>.generate(10, (i) {
      final index = baseIndex + i;
      final level = HomeAlertLevel.values[index % HomeAlertLevel.values.length];
      return HomeGranaryItem(
        idText: 'HB${(index + 1).toString().padLeft(4, '0')}',
        updatedAtText: '2021-11-10 12:00:${(index % 60).toString().padLeft(2, '0')}',
        averageBugText: '20℃',
        averageHumidityText: '10%',
        averageCo2Text: '20℃',
        bugStatusText: index % 3 == 0 ? '有虫' : '无虫',
        level: level,
      );
    });
  }
}

/// 顶部指标模型
class HomeTopMetric {
  /// 指标名称
  final String label;

  /// 指标值
  final String valueText;

  /// 粮仓信息
  final String granaryText;

  /// 文本颜色
  final Color color;

  const HomeTopMetric({
    required this.label,
    required this.valueText,
    required this.granaryText,
    required this.color,
  });
}

/// 粮仓列表项模型
class HomeGranaryItem {
  /// 粮仓编号
  final String idText;

  /// 更新时间
  final String updatedAtText;

  /// 平均虫量
  final String averageBugText;

  /// 平均湿度
  final String averageHumidityText;

  /// 平均 CO2
  final String averageCo2Text;

  /// 虫情状态
  final String bugStatusText;

  /// 告警等级
  final HomeAlertLevel level;

  const HomeGranaryItem({
    required this.idText,
    required this.updatedAtText,
    required this.averageBugText,
    required this.averageHumidityText,
    required this.averageCo2Text,
    required this.bugStatusText,
    required this.level,
  });
}

/// 告警等级（用于卡片配色）
enum HomeAlertLevel {
  /// 正常
  normal,

  /// 关注
  warning,

  /// 严重
  danger,
}
