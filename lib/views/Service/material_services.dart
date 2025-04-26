import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class MaterialServices {
  Future<void> fetchMaterials() async {
    final url = Uri.parse('https://www.itech-sy.com/api/material_all_get.php');

    final response = await http.post(
      url,
      body: {'database_name': 'itechsy_test', 'source': 'material'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log(data.toString());
    } else {
      print('خطأ في الاتصال: ${response.statusCode}');
    }
  }
}
