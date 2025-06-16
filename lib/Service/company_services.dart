import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class CompanyServices {
  static const String _baseUrl = 'https://www.itech-sy.com/api';
  static final String _activateAndCheckUrl = '$_baseUrl/activate_and_check.php';
  static final String _getDevicesUrl = '$_baseUrl/get_company_device.php';
  static final String _deleteDeviceUrl = '$_baseUrl/delet_device.php';
  static Future<String> deleteDevice({
    required int comId,
    required String imei,
    required String userName,
  }) async {
    final url = Uri.parse(_deleteDeviceUrl);
    final response = await http.post(
      url,
      body: {'com_id': comId.toString(), 'imei': imei, 'user_name': userName},
    );
    log(response.body);
    if (response.statusCode != 200) {
      throw Exception('فشل الاتصال بالخادم.');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (data['status'] == 'success') {
      return data['message'];
    } else {
      throw Exception(data['message']);
    }
  }

  static Future<Map<String, dynamic>> verifyAndActivateDevice({
    required String companyName,
    required String serialKey,
    required String imei,
    required String userName,
  }) async {
    final url = Uri.parse(_activateAndCheckUrl);
    final response = await http.post(
      url,
      body: {
        'com_name': companyName,
        'com_serial': serialKey,
        'imei': imei,
        'user_name': userName,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('فشل الاتصال بالخادم.');
    }
    final Map<String, dynamic> data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      return data;
    } else {
      throw Exception(data['message']);
    }
  }

  static Future<Map<String, String>> getCompanyDevices({
    required int comId,
  }) async {
    final url = Uri.parse(_getDevicesUrl);
    final response = await http.post(url, body: {'com_id': comId.toString()});
    if (response.statusCode != 200) {
      throw Exception('فشل الاتصال بالخادم.');
    }
    final json = jsonDecode(response.body);
    if (json['status'] == 'success') {
      final Map<String, String> devices = Map<String, String>.from(
        json['devices'],
      );
      return devices;
    } else {
      throw Exception('فشل في جلب الاجهزة');
    }
  }
}
