import 'package:get_storage/get_storage.dart';

class AuthUtils {
  //简易登录状态工具类，基于 GetStorage 持久化
  static const _boxName = 'auth_box';
  static const _keyLoggedIn = 'is_logged_in';

  //初始化存储
  static Future<void> init() async {
    await GetStorage.init(_boxName);
  }

  //读取登录状态
  static bool isLoggedIn() {
    final box = GetStorage(_boxName);
    return box.read<bool>(_keyLoggedIn) ?? false;
  }

  //设置登录状态
  static Future<void> setLoggedIn(bool value) async {
    final box = GetStorage(_boxName);
    await box.write(_keyLoggedIn, value);
  }
}

