import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class DebitService {
  static const String _baseUrl = 'https://www.itech-sy.com/api';
  static final String _urlAddDebit = '$_baseUrl/debit_add.php';

  static Future<void> addDebitWithDetails({
    required Map<String, dynamic> debit,
    required List<Map<String, dynamic>> details,
  }) async {
    final url = Uri.parse(_urlAddDebit);
    final body = {
      ...debit.map((key, value) => MapEntry(key, value.toString())),
      'details': jsonEncode(details),
    };

    try {
      final response = await http.post(url, body: body);

      // التحقق من نجاح الاستجابة
      if (response.statusCode != 200) {
        throw Exception("خطأ في الاتصال: ${response.statusCode} - ${response.reasonPhrase}");
      }

      final json = jsonDecode(response.body);

      // التحقق مما إذا كان هناك خطأ قادم من `PHP`
      if (json.containsKey('error')) {
        log("خطأ من PHP: ${json['error']}");
        throw Exception(json['error']); // عرض الخطأ الحقيقي مباشرةً
      }

      // التحقق من نجاح العملية
      if (json['deb_id'] != null) {
        log("تم إدراج السجل بنجاح برقم: ${json['deb_id']}");
      }
    } catch (e) {
      log("حدث خطأ أثناء الإضافة: $e");
      throw Exception("فشل العملية: $e"); // عرض الخطأ كما هو دون تعديل
    }
  }
}
