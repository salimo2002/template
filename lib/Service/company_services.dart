import 'dart:convert';
import 'package:http/http.dart' as http;

class CompanyServices {
  static const String _baseUrl = 'https://www.itech-sy.com/api';

  static final String _checkCompanyUrl = '$_baseUrl/check_company.php';
  static final String _getDevicesUrl = '$_baseUrl/get_company_devices.php';
  static final String _activateDeviceUrl = '$_baseUrl/activate_device.php';

  static Future<Map<String, dynamic>> checkCompany({
    required String companyName,
    required String comSerial,
  }) async {
    final url = Uri.parse(_checkCompanyUrl);
    final response = await http.post(
      url,
      body: {'com_name': companyName, 'com_serial': comSerial},
    );

    if (response.statusCode != 200) {
      throw Exception('فشل الاتصال بالخادم.');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }

  static Future<List<String>> getCompanyDevices({required int comId}) async {
    final url = Uri.parse(_getDevicesUrl);
    final response = await http.post(url, body: {'com_id': comId.toString()});

    if (response.statusCode != 200) {
      throw Exception('فشل الاتصال بالخادم.');
    }

    final json = jsonDecode(response.body);
    if (json['status'] == 'success') {
      return List<String>.from(json['devices']);
    } else {
      throw Exception('فشل في جلب الأجهزة.');
    }
  }

  static Future<Map<String, dynamic>> activateDevice({
    required int comId,
    required String imei,
  }) async {
    final url = Uri.parse(_activateDeviceUrl);
    final response = await http.post(
      url,
      body: {'com_id': comId.toString(), 'imei': imei},
    );

    if (response.statusCode != 200) {
      throw Exception('فشل الاتصال بالخادم.');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }
}
