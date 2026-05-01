import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<(String, String)> deviceInfo() async {
  final deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    return (androidInfo.id, androidInfo.name);
  }
  if (Platform.isWindows) {
    final windowsInfo = await deviceInfo.windowsInfo;
    return (windowsInfo.deviceId, windowsInfo.userName);
  }
  return ('unknown', 'unknown');
}
