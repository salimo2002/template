import 'dart:convert';
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
  //bille_get_all.php
  /// جلب كل الفواتير مع تفاصيلها
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

    final body =
        bill.toMap()
          ..['details'] = jsonEncode(details.map((e) => e.toMap()).toList());

    final response = await http.post(url, body: body);

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
    required String databaseName,
  }) async {
    final url = Uri.parse(_urlUpdateBill);

    // تحويل التفاصيل إلى قائمة JSON
    List<Map<String, dynamic>> detailsList =
        details.map((e) => e.toJson()).toList();

    // إعداد البيانات
    final body = {
      'database_name': databaseName,
      'bil_id': bill.bilId.toString(),
      'acc_id': bill.accId.toString(),
      'bil_number': bill.bilNumber,
      'bil_total': bill.bilTotal.toString(),
      'bil_discount': bill.bilDiscount.toString(),
      'bil_extra': bill.bilExtra.toString(),
      'bil_kind': bill.bilKind,
      'bil_payment': bill.bilPayment.toString(),
      'BIL_DATE':bill.bilDate,
      'BIL_NOTE':bill.bilNote,
      'details': jsonEncode(detailsList),
    };

    try {
      final response = await http.post(url, body: body);
      final json = jsonDecode(response.body);

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
      return {'success': false, 'error': 'Exception', 'message': e.toString()};
    }
  }
}
