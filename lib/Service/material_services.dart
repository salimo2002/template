import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:template/models/material_model.dart';

class MaterialServices {
  static final String _urlFetchMaterials =
      'https://www.itech-sy.com/api/material_all_get.php';

  static final String _urlAddMaterial =
      'https://www.itech-sy.com/api/material_insert.php';

  static final String _urlDeleteMaterial =
      'https://www.itech-sy.com/api/material_delete.php';

  static final String _urlUpdateNameById =
      'https://www.itech-sy.com/api/material_update.php';

  static Future<List<dynamic>> fetchMaterials() async {
    final url = Uri.parse(_urlFetchMaterials);

    final response = await http.post(
      url,
      body: {'database_name': 'itechsy_test', 'source': 'material'},
    );
    try {
      List<dynamic> data = jsonDecode(response.body);

      return data;
    } catch (e) {
      throw Exception('خطأ في الاتصال');
    }
  }

  static Future<int> addMaterial(MaterialModel mat) async {
    final url = Uri.parse(_urlAddMaterial);
    final response = await http.post(url, body: mat.toMap());

    if (response.statusCode != 200) {
      throw Exception('خطأ في الاتصال: ${response.statusCode}');
    }

    final json = jsonDecode(response.body);
    if (json['material_id'] != null) {
      return int.parse(json['material_id'].toString());
    }
    throw Exception('فشل الإضافة: $json');
  }

  static Future<bool> deleteMaterial(int id) async {
    final url = Uri.parse(_urlDeleteMaterial);
    final response = await http.post(
      url,
      body: {'database_name': 'itechsy_test', 'MAT_ID': id.toString()},
    );
    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}');
    }
    final json = jsonDecode(response.body);
    if (json['success'] == true) return true;
    throw Exception('Delete failed: ${json['error']}');
  }

  static Future<bool> updateMaterialById(MaterialModel model) async {
    final url = Uri.parse(_urlUpdateNameById);

    final response = await http.post(url, body: model.toMap());
    final json = jsonDecode(response.body);

    if (response.statusCode == 200 && json['success'] == true) {
      return true;
    } else {
      throw Exception('Update failed: ${json['error']}');
    }
  }
}
