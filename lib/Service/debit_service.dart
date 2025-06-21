import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:template/cubit/company%20cubit/company_cubit.dart';
import 'package:template/models/debit_model.dart';

class DebitService {
  static const String _baseUrl = 'https://www.itech-sy.com/api';
  static final String _urlAddDebit = '$_baseUrl/debit_add.php';
  static final String _urlGetDebits = '$_baseUrl/debit_get_all.php';
  static final String _urlDeleteDebit = '$_baseUrl/delete_debit.php';
  static const String _urlUpdateDebit = '$_baseUrl/update_debit.php';

  static Future<void> addDebit({required DebitModel debit}) async {
    final url = Uri.parse(_urlAddDebit);

    final body = {
      'database_name': CompanyCubit.comp.dataBase,
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

      if (json['deb_id'] != null) {}
    } catch (e) {
      throw Exception("فشل العملية: $e");
    }
  }

  static Future<List<DebitModel>> fetchDebits({
    String? dateFrom,
    String? dateTo,
  }) async {
    final url = Uri.parse(_urlGetDebits);

    final body = {'database_name': CompanyCubit.comp.dataBase};

    if (dateFrom != null && dateTo != null) {
      body['date_from'] = dateFrom;
      body['date_to'] = dateTo;
    }

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded is List) {
          return decoded.map((json) => DebitModel.fromJson(json)).toList();
        } else if (decoded is Map && decoded.containsKey('error')) {
          throw Exception('خطأ: ${decoded['error']}');
        } else {
          throw Exception('بيانات غير متوقعة من الخادم');
        }
      } else {
        throw Exception('فشل في جلب البيانات: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('حدث خطأ أثناء جلب البيانات: $e');
    }
  }

  static Future<void> deleteDebit({required int debId}) async {
    final url = Uri.parse(_urlDeleteDebit);

    final body = {
      'database_name': CompanyCubit.comp.dataBase,
      'deb_id': debId.toString(),
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );

      if (response.statusCode != 200) {
        throw Exception("خطأ في الاتصال: ${response.statusCode}");
      }

      final decoded = jsonDecode(response.body);

      if (decoded is Map && decoded.containsKey('error')) {
        throw Exception("خطأ من الخادم: ${decoded['error']}");
      }

      if (decoded is Map && decoded['success'] == true) {
        return;
      } else {
        throw Exception(
          "فشل في حذف السند: ${decoded['message'] ?? 'غير معروف'}",
        );
      }
    } catch (e) {
      throw Exception("فشل العملية: $e");
    }
  }

  static Future<void> updateDebit({
    required DebitModel debit,
  }) async {
    final url = Uri.parse(_urlUpdateDebit);

    final Map<String, String> mapData = debit.toMap().map(
      (key, value) => MapEntry(key, value.toString()),
    );
    mapData['deb_id'] =
        debit.debId.toString(); // تأكد إعادة تعيين قيمة deb_id الصحيحة

    final body = {
      'deb_id': debit.debId.toString(),

      'database_name': CompanyCubit.comp.dataBase,
      ...mapData,
    };
    print('updateDebit body: $body');

    try {
      final response = await http.post(url, body: body);

      if (response.statusCode != 200) {
        throw Exception("فشل الاتصال بالخادم: ${response.statusCode}");
      }

      final json = jsonDecode(response.body);

      if (json is Map && json.containsKey('error')) {
        throw Exception("خطأ من السيرفر: ${json['error']}");
      }
    } catch (e) {
      throw Exception("فشل في تعديل السند: $e");
    }
  }
}
