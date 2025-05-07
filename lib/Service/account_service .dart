// ignore: file_names
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:template/models/account_model.dart';

class AccountService {
  static const String _urlFetchAccounts =
      'https://www.itech-sy.com/api/account_all_get.php';
  static const String _urlCreateAccount =
      'https://www.itech-sy.com/api/account_create.php';

  static const String _urlDeleteAccount =
      'https://www.itech-sy.com/api/account_delete.php';

  static const String _urlUpdateAccount =
      'https://www.itech-sy.com/api/account_update.php';

  static Future<List<dynamic>> fetchAccounts() async {
    final url = Uri.parse(_urlFetchAccounts);

    try {
      final response = await http
          .post(url, body: {'database_name': 'itechsy_test'})
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        print(data.toString());
        return data
            .map<AccountModel>((json) => AccountModel.fromJson(json))
            .toList();
      } else {
        throw Exception('فشل في جلب البيانات: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('خطأ في الاتصال بالخادم: ${e.message}');
    } on TimeoutException {
      throw Exception('انتهى وقت الانتظار، يرجى المحاولة مرة أخرى');
    } on FormatException {
      throw Exception('خطأ في تنسيق البيانات المستلمة');
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }

  static Future createAccount({required AccountModel account}) async {
    final url = Uri.parse(_urlCreateAccount);

    try {
      final response = await http
          .post(url, body: account.toMap())
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData.containsKey('error')) {
          throw Exception(responseData['error']);
        }
        log(responseData);
        return responseData;
      } else {
        throw Exception('فشل في إنشاء الحساب: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('حدث خطأ أثناء إنشاء الحساب: $e');
    }
  }

  static Future<Map<String, dynamic>> updateAccount({
    required int accId,
    required AccountModel account,
  }) async {
    final url = Uri.parse(_urlUpdateAccount);

    try {
      final body = {'ACC_ID': accId.toString(), ...account.toMap()};

      final response = await http
          .post(url, body: body)
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData.containsKey('error')) {
          throw Exception(responseData['error']);
        }

        return responseData;
      } else {
        throw Exception('فشل في تحديث الحساب: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('حدث خطأ أثناء تحديث الحساب: $e');
    }
  }

  static Future<Map<String, dynamic>> deleteAccount({
    required int accId,
  }) async {
    final url = Uri.parse(_urlDeleteAccount);

    try {
      final response = await http
          .post(
            url,
            body: {'database_name': 'itechsy_test', 'ACC_ID': accId.toString()},
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData.containsKey('error')) {
          throw Exception(responseData['error']);
        }

        return responseData;
      } else {
        throw Exception('فشل في حذف الحساب: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      throw Exception('خطأ في الاتصال بالخادم: ${e.message}');
    } on TimeoutException {
      throw Exception('انتهى وقت الانتظار، يرجى المحاولة مرة أخرى');
    } on FormatException {
      throw Exception('خطأ في تنسيق البيانات المستلمة');
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }
}
