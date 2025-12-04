import 'package:permission_handler/permission_handler.dart';
import 'appLogger.dart';

class PermissionUtil {
  const PermissionUtil._();

  // 【AI修改】检查并请求单个权限
  static Future<bool> checkAndRequest(Permission permission) async {
    final status = await permission.status;
    if (status.isGranted) return true;
    final result = await permission.request();
    final granted = result.isGranted;
    if (!granted && result.isPermanentlyDenied) {
      AppLogger.w('Permission permanently denied: $permission');
    }
    return granted;
  }

  // 【AI修改】批量请求权限
  static Future<Map<Permission, bool>> requestMultiple(
    List<Permission> permissions,
  ) async {
    final results = await permissions.request();
    return results.map((key, value) => MapEntry(key, value.isGranted));
  }

  // 【AI修改】跳转到系统设置
  static Future<bool> openSettings() => openAppSettings();
}

