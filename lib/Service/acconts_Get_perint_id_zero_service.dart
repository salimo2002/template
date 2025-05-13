import 'dart:convert';

import 'package:http/http.dart' as http;

class ParentAccountsService {
  static const String _accontsGetPerintIdZero =
      'https://www.itech-sy.com/api/acconts_get_perintId_zero_in.php';

  static Future<List<dynamic>> accontsGetPerintIdZero() async {
    final url = Uri.parse(_accontsGetPerintIdZero);
    final response = await http.post(
      url,
      body: {'database_name': 'itechsy_test', 'source': 'account'},
    );
    try {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      return data;
    } catch (e) {
      throw Exception('خطأ في الاتصال');
    }
  }
}
