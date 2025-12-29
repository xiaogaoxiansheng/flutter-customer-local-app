import 'package:get/get.dart';

/// 设备详情页控制器
/// 管理页面数据、分页加载与滚动监听
class DeviceDetailsController extends GetxController {
  /// 当前设备 ID
  final deviceId = 'LD05F24071200080'.obs;

  /// 当前设备型号
  final modelText = 'LD05'.obs;

  /// 在线状态
  final onlineStatusText = '在线'.obs;

  /// 工作状态
  final workStatusText = '工作中'.obs;

  /// 顶部能力信息
  final captureStrengthText = '普通'.obs;
  final brightnessText = '普通'.obs;
  final spectrumPowerText = '普通'.obs;

  /// 基础信息
  final locationText =
      '甘肃省金昌市金川区某粮食储备有限公司-甘肃省金昌市金川区\n公司-甘肃金昌P1'
          .obs;

  /// 设备别名
  final deviceNameText = 'LD05_F_User_V028'.obs;

  /// 图库信息
  final aiInsectCountText = '--'.obs;
  final insectDensityText = '无虫'.obs;

  /// 虫情概览
  final weeklyInsectCountText = '0头/周'.obs;
  final weeklyIncreaseText = '--头/周'.obs;

  /// 告警数量
  final alarmCountText = '0'.obs;

  /// 工作时间
  final workTimeText = '00:00:00-24:00:00'.obs;

  /// 传感器列表
  final sensors = <DeviceSensorItem>[].obs;

  /// 告警列表
  final alarms = <DeviceAlarmItem>[].obs;

  /// 首次加载状态
  final isInitialLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  /// 加载页面数据
  Future<void> _loadData() async {
    isInitialLoading.value = true;
    sensors.clear();
    alarms.clear();
    
    final sensorData = await _fetchAllSensors();
    sensors.assignAll(sensorData);
    
    final alarmData = await _fetchAlarms();
    alarms.assignAll(alarmData);

    alarmCountText.value = alarmData.length.toString();
    
    isInitialLoading.value = false;
  }

  /// 模拟获取告警列表
  Future<List<DeviceAlarmItem>> _fetchAlarms() async {
    // 模拟数据
    return [
      DeviceAlarmItem(
        tag: '虫量告警',
        content: '识别到较多虫害，请及时处理。',
        time: '16:36:02',
      ),
      DeviceAlarmItem(
        tag: '虫量告警',
        content: '识别到较多虫害，请及时处理。',
        time: '15:36:06',
      ),
      DeviceAlarmItem(
        tag: '虫量告警',
        content: '识别到较多虫害，请及时处理。',
        time: '14:36:24',
      ),
    ];
  }

  /// 一次性加载全部传感器列表
  Future<List<DeviceSensorItem>> _fetchAllSensors() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    return List<DeviceSensorItem>.generate(18, (index) {
      final name = switch (index % 6) {
        0 => '二氧化碳(#0)'
            '：408PP...',
        1 => '湿度(#1)：51.6%...',
        2 => '温度(#1)：7℃',
        3 => '湿度(#3)：50.9%...',
        4 => '温度(#2)：4.8℃',
        _ => '温度(#3)：6℃',
      };

      return DeviceSensorItem(
        id: 'sensor_$index',
        name: name,
        valueText: '离线',
        isWarn: true,
      );
    });
  }
}

/// 传感器列表项
class DeviceSensorItem {
  /// 唯一标识
  final String id;

  /// 传感器名称与读数
  final String name;

  /// 状态文本
  final String valueText;

  /// 是否告警
  final bool isWarn;

  DeviceSensorItem({
    required this.id,
    required this.name,
    required this.valueText,
    this.isWarn = false,
  });
}

/// 告警列表项
class DeviceAlarmItem {
  final String tag;
  final String content;
  final String time;

  DeviceAlarmItem({
    required this.tag,
    required this.content,
    required this.time,
  });
}
