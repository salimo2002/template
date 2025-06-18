import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/bill_model.dart';
import '../models/bill_details_model.dart';

class BillServices {
  static const String _baseUrl = 'https://www.itech-sy.com/api';

  static final String _urlFetchBills = '$_baseUrl/bille_get_all.php';
  static final String _urlAddBill = '$_baseUrl/bill_add.php';
  static final String _urlFetchBillDetails =
      '$_baseUrl/bille_details_get_all.php';

  static final String _urlDeleteBill = '$_baseUrl/bill_delet.php';
  static final String _urlUpdateBill = '$_baseUrl/bill_update.php';
  static final String _urlFetchBillsWithDetailsFiltered =
      '$_baseUrl/billllllll.php';
  static Future<List> fetchBillss() async {
    final url = Uri.parse(_urlFetchBills);
    final response = await http.post(
      url,
      body: {'database_name': 'itechsy_test'},
    );

    if (response.statusCode != 200) {
      throw Exception('فشل في الاتصال');
    }

    try {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } catch (e) {
      throw Exception('فشل في تحليل البيانات: $e');
    }
  }

  static Future<List> fetchBillDetails() async {
    final url = Uri.parse(_urlFetchBillDetails);
    final response = await http.post(
      url,
      body: {'database_name': 'itechsy_test'},
    );

    if (response.statusCode != 200) {
      throw Exception('فشل في الاتصال');
    }

    try {
      List<dynamic> data = jsonDecode(response.body);

      return data;
    } catch (e) {
      throw Exception('فشل في تحليل البيانات: $e');
    }
  }

  /// إضافة فاتورة مع التفاصيل في نفس الوقت
  static Future<int> addBillWithDetails({
    required BillModel bill,
    required List<BillDetailsModel> details,
  }) async {
    final url = Uri.parse(_urlAddBill);

    final body = {
      ...bill.toMap(),
      'details': jsonEncode(details.map((e) => e.toMap()).toList()),
      'database_name': 'itechsy_test',
    };

    final response = await http.post(url, body: body);
    print(response.body); // بعد await http.post(...)

    log(jsonEncode(body)); // للتأكد من البيانات قبل الإرسال

    if (response.statusCode != 200) {
      throw Exception('فشل الاتصال عند الإضافة');
    }

    final json = jsonDecode(response.body);
    if (json['bil_id'] != null) {
      return int.parse(json['bil_id'].toString());
    }

    throw Exception('فشل في الإضافة: $json');
  }

  /// حذف فاتورة (مع تفاصيلها)
  static Future<bool> deleteBill(int billId) async {
    final url = Uri.parse(_urlDeleteBill);
    final response = await http.post(
      url,
      body: {'database_name': 'itechsy_test', 'bil_id': billId.toString()},
    );

    if (response.statusCode != 200) {
      throw Exception('فشل الاتصال عند الحذف');
    }

    final json = jsonDecode(response.body);
    return json['success'] == true;
  }

  static Future<Map<String, dynamic>> updateBillWithDetails({
    required BillModel bill,
    required List<BillDetailsModel> details,
  }) async {
    final url = Uri.parse(_urlUpdateBill);

    // إعداد البيانات
    final body = {
      ...bill.toMap(), // استخدام الموديل مباشرة
      'details': jsonEncode(details.map((e) => e.toMap()).toList()),
    };

    try {
      final response = await http.post(url, body: body);
      final json = jsonDecode(response.body);
      log(response.body); // ✅ أضف هذا السطر لرؤية الرد القادم من PHP

      if (response.statusCode == 200 && json['success'] == true) {
        return {'success': true, 'bil_id': json['bil_id']};
      } else {
        return {
          'success': false,
          'error': json['error'],
          'message': json['message'],
        };
      }
    } catch (e) {
      log(e.toString());
      return {'success': false, 'error': 'Exception', 'message': e.toString()};
    }
  }

  /// جلب الفواتير مع تفاصيلها بين تاريخين مع فلترة حسب acc_id أو bil_kind
  static Future<List<Map<String, dynamic>>> fetchBillsWithDetailsFiltered({
    required String dateFrom,
    required String dateTo,
    int? accId,
    String? bilKind,
  }) async {
    final url = Uri.parse(_urlFetchBillsWithDetailsFiltered);
    final Map<String, String> body = {
      'database_name': 'itechsy_test',
      'date_from': dateFrom,
      'date_to': dateTo,
    };

    if (accId != null) {
      body['acc_id'] = accId.toString();
    } else if (bilKind != null) {
      body['bil_kind'] = bilKind;
    }

    final response = await http.post(url, body: body);

    if (response.statusCode != 200) {
      throw Exception('فشل في الاتصال بالسيرفر');
    }

    try {
      final List<dynamic> data = jsonDecode(response.body);
      log(data.toString());
      return data.cast<Map<String, dynamic>>();
    } catch (e) {
      log("خطأ في التحويل: $e");
      throw Exception('فشل في تحليل البيانات: $e');
    }
  }
}
