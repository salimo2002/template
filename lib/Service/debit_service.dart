import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:template/models/debit_model.dart';

class DebitService {
  static const String _baseUrl = 'https://www.itech-sy.com/api';
  static final String _urlAddDebit = '$_baseUrl/debit_add.php';
  static final String _urlGetDebits = '$_baseUrl/debit_get_all.php';

static Future<void> addDebit({required DebitModel debit}) async {
  final url = Uri.parse(_urlAddDebit);
  
 
  final body = {
    ...debit.toMap().map((key, value) => MapEntry(key, value.toString())),
  };


  try {
    final response = await http.post(url, body: body);


    if (response.statusCode != 200) {
      throw Exception(
        "خطأ في الاتصال: ${response.statusCode} - ${response.reasonPhrase}",
      );
    }

    final json = jsonDecode(response.body);

    if (json.containsKey('error')) {
      throw Exception(json['error']);
    }

    if (json['deb_id'] != null) {
    }
  } catch (e) {
    throw Exception("فشل العملية: $e");
  }
}

static Future<List<DebitModel>> fetchDebits() async {
  final url = Uri.parse(_urlGetDebits);

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type':'application/x-www-form-urlencoded'},
      body: {'database_name': 'itechsy_test'},
    );


    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => DebitModel.fromJson(json)).toList();
    } else {
      throw Exception('فشل في جلب البيانات: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('حدث خطأ أثناء جلب البيانات: $e');
  }
}

}
