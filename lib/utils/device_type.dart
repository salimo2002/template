// import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';

// class DeviceType {
//   static Future<String?> getDeviceImei() async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     if (Platform.isAndroid) {
//       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//       // IMEI قد لا تتوفر مباشرة بسبب صلاحيات Android 10+
//       // بديل: جلب androidId (مُعرف فريد للجهاز)
//       return androidInfo.id;
//     } else if (Platform.isIOS) {
//       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//       // iOS لا تسمح بالوصول لـ IMEI
//       return iosInfo.identifierForVendor; // معرف فريد بديل
//     }
//     return null;
//   }
// }
