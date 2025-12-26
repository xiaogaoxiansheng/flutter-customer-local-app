import 'package:get/get.dart';

/// 设备列表项模型
/// 用于驱动列表 UI 显示
class DeviceItem {
  final String id;
  final String model;
  final String direction;
  final bool ledOn;
  final bool hasBug;
  final int alarmCount;

  const DeviceItem({
    required this.id,
    required this.model,
    required this.direction,
    required this.ledOn,
    required this.hasBug,
    required this.alarmCount,
  });
}

class DeviceController extends GetxController {
  /// 设备列表页控制器
  /// 管理设备数据与顶部统计

  // 示例主图地址（统一使用）
  static const String imageUrl =
      'https://img2.baidu.com/it/u=2748410042,3263196381&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500';

  // 顶部位置文本
  final locationText =
      '第二储粮生态区某省/市/地区粮库-粮仓1号'.obs;

  // 设备列表
  final items = <DeviceItem>[].obs;

  // 统计数据
  int get onlineCount => items.where((e) => e.ledOn).length;
  int get offlineCount => items.where((e) => !e.ledOn).length;

  @override
  void onInit() {
    super.onInit();
    // 构造示例数据
    items.assignAll([
      const DeviceItem(
        id: 'LD05F23032200001',
        model: 'LD20',
        direction: '东南',
        ledOn: true,
        hasBug: false,
        alarmCount: 0,
      ),
      const DeviceItem(
        id: 'LD05F23032200001',
        model: 'LD20',
        direction: '东南',
        ledOn: false,
        hasBug: true,
        alarmCount: 0,
      ),
      const DeviceItem(
        id: 'LD05F23032200001',
        model: 'LD20',
        direction: '东南',
        ledOn: true,
        hasBug: false,
        alarmCount: 0,
      ),
      const DeviceItem(
        id: 'LD05F23032200001',
        model: 'LD20',
        direction: '东南',
        ledOn: false,
        hasBug: false,
        alarmCount: 0,
      ),const DeviceItem(
        id: 'LD05F23032200001',
        model: 'LD20',
        direction: '东南',
        ledOn: false,
        hasBug: false,
        alarmCount: 0,
      ),const DeviceItem(
        id: 'LD05F23032200001',
        model: 'LD20',
        direction: '东南',
        ledOn: false,
        hasBug: false,
        alarmCount: 0,
      ),
    ]);
  }

  /// 开灯操作（示例：全部置为开）
  void openLedAll() {
    items.value = items.map((e) => DeviceItem(
          id: e.id,
          model: e.model,
          direction: e.direction,
          ledOn: true,
          hasBug: e.hasBug,
          alarmCount: e.alarmCount,
        )).toList();
    items.refresh();
  }

  /// 关灯操作（示例：全部置为关）
  void closeLedAll() {
    items.value = items.map((e) => DeviceItem(
          id: e.id,
          model: e.model,
          direction: e.direction,
          ledOn: false,
          hasBug: e.hasBug,
          alarmCount: e.alarmCount,
        )).toList();
    items.refresh();
  }

  /// 拍照（示例：无实际功能）
  void takePhoto() {}
}
