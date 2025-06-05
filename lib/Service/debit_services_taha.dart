import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/debit_model.dart';
import '../models/deb_details_model.dart';

class DebitServices2 {
  static const String _baseUrl = 'https://www.itech-sy.com/api';

  static final String _urlAddDebit = '$_baseUrl/debit_add10.php';

  static final String _urlFetchDebits = '$_baseUrl/debit_get_all.php';
  static final String _urlDeleteDebit = '$_baseUrl/debit_delete.php';

  /// إضافة سند مع تفاصيله
  static Future<int> addDebitWithDetails({
    required DebitModel debit,
    required List<DebDetailsModel> details,
    String databaseName = 'itechsy_test',
  }) async {
    final url = Uri.parse(_urlAddDebit);

    final body = {
      'database_name': databaseName,
      ...debit.toMap().map((key, value) => MapEntry(key, value.toString())),
      'details': jsonEncode(details.map((e) => e.toMap()).toList()),
    };

    final response = await http.post(url, body: body);

    if (response.statusCode != 200) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('فشل الاتصال بالسيرفر');
      }

      throw Exception('فشل الاتصال بالسيرفر');
    }

    final json = jsonDecode(response.body);

    if (json['deb_id'] != null) {
      return int.parse(json['deb_id'].toString());
    }

    throw Exception('فشل في إضافة السند: $json');
  }

  /// جلب جميع السندات
  static Future<List> fetchDebits({
    String databaseName = 'itechsy_test',
  }) async {
    final url = Uri.parse(_urlFetchDebits);
    final response = await http.post(
      url,
      body: {'database_name': databaseName},
    );

    if (response.statusCode != 200) {
      throw Exception('فشل الاتصال عند الجلب');
    }

    try {
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('خطأ في تحليل بيانات السندات: $e');
    }
  }

  /// حذف سند (حسب id)
  static Future<bool> deleteDebit(
    int debId, {
    String databaseName = 'itechsy_test',
  }) async {
    final url = Uri.parse(_urlDeleteDebit);
    final response = await http.post(
      url,
      body: {'database_name': databaseName, 'deb_id': debId.toString()},
    );

    if (response.statusCode != 200) {
      throw Exception('فشل الاتصال عند الحذف');
    }

    final json = jsonDecode(response.body);
    return json['success'] == true;
  }
}
