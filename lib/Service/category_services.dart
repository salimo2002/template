import 'dart:convert';

import 'package:template/models/category_model.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CategoryServices {
  static final String _urlAddCategory =
      'https://www.itech-sy.com/api/category_insert.php';
  static final String _urlFetchCategory =
      'https://www.itech-sy.com/api/category_all_get.php';

  static final String _urlCategoryUpdate =
      'https://www.itech-sy.com/api/category_update.php';
  static final String _urlCategoryDelet =
      'https://www.itech-sy.com/api/category_delet.php';
  static Future<bool> categoryDeletById({required String matId}) async {
    final uri = Uri.parse(_urlCategoryDelet);

    try {
      final response = await http.post(
        uri,
        body: {'database_name': 'itechsy_test', 'mat_id': matId},
      );

      if (response.statusCode == 200) {
        final body = response.body;
        if (body.contains('"success":true')) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<void> updateCategory(CategoryModel mat) async {
    final url = Uri.parse(_urlCategoryUpdate);

    final response = await http.post(
      url,
      body: {
        'database_name': 'itechsy_test',
        'mat_id': mat.matId.toString(),
        'mat_name': mat.matName,
      },
    );
    debugPrint(response.body);
    final result = jsonDecode(response.body);
    if (result['success'] != true) {
      throw Exception('فشل في تعديل التصنيف');
    }
  }

  static Future<int> addCategory(CategoryModel mat) async {
    final url = Uri.parse(_urlAddCategory);
    final response = await http.post(url, body: mat.toMap());

    if (response.statusCode != 200) {
      throw Exception('خطأ في الاتصال: ${response.statusCode}');
    }

    final json = jsonDecode(response.body);
    if (json['material_id'] != null) {
      log('yes');
      return int.parse(json['material_id'].toString());
    }
    throw Exception('فشل الإضافة: $json');
  }

  static Future<List<dynamic>> fetchCategory() async {
    final url = Uri.parse(_urlFetchCategory);

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
}
