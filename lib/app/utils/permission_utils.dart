import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  const PermissionUtils._();

  static Future<bool> isGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  static Future<bool> request(Permission permission) async {
    final status = await permission.status;
    if (status.isGranted) return true;
    final result = await permission.request();
    return result.isGranted;
  }

  static Future<Map<Permission, PermissionStatus>> requestBatch(
    List<Permission> permissions,
  ) async {
    return permissions.request();
  }

  static Future<bool> ensure(Permission permission) async {
    final granted = await isGranted(permission);
    if (granted) return true;
    final result = await permission.request();
    if (result.isPermanentlyDenied) {
      return await openSettings();
    }
    return result.isGranted;
  }

  static Future<bool> openSettings() async {
    final opened = await openAppSettings();
    return opened;
  }
}

