import 'dart:convert';

import 'package:http/http.dart' as http;

class SettingService {
  static const String _baseUrl = 'https://www.itech-sy.com/api';
  static final String _urlFetchSetting = '$_baseUrl/fetch_setting.php';
  static Future<List<dynamic>> fetchMovementBills({
    required String databaseName,
    required String dateFrom,
    required String dateTo,
    required String matId,
  }) async {
    final url = Uri.parse(_urlFetchSetting);
    final response = await http.post(
      url,
      body: {'database_name': databaseName},
    );
    if (response.statusCode != 200) {
      throw Exception('فشل في الاتصال بالسيرفر');
    }
    try {
      final List<dynamic> data = jsonDecode(response.body);
      return data;
    } catch (e) {
      throw Exception('فشل في تحليل البيانات: $e');
    }
  }
}
