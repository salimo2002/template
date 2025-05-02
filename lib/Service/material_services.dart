import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:template/models/category_model.dart';
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
          print('فشل في الحذف: $body');
          return false;
        }
      } else {
        print('استجابة غير ناجحة: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('خطأ أثناء الحذف: $e');
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
      log(data.toString());
      return data;
    } catch (e) {
      throw Exception('خطأ في الاتصال');
    }
  }

  static Future<List<dynamic>> fetchMaterials() async {
    final url = Uri.parse(_urlFetchMaterials);

    final response = await http.post(
      url,
      body: {'database_name': 'itechsy_test', 'source': 'material'},
    );
    try {
      List<dynamic> data = jsonDecode(response.body);
      log(data.toString());
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
    final body = {
      'database_name': 'itechsy_test',
      'MAT_ID': model.materialId.toString(),
      'MAT_NUMBER': model.materialNumber,
      'MAT_NAME': model.materialName,
      'MAT_CODE': model.materialCode,
      'MAT_PRICE1': model.materialPrice1.toString(),
      'MAT_PRICE3': model.materialPrice3.toString(),
      'MAT_UNIT': model.materialUnit,
      'MAT_UNIT2': model.materialUnit2,
      'MAT_UNIT2_NUM': model.materialUnit2Number.toString(),
      'MAT_UNIT2_PRICE3': model.materialUnit2Price3.toString(),
      'MAT_KIND': model.materialKind.toString(),
      'mat_unit_default': model.materialUnitDefault.toString(),
      'mat_image': model.materialImage,
      'PARENT_ID': model.parentId.toString(),
    };

    final response = await http.post(url, body: body);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200 && json['success'] == true) {
      return true;
    } else {
      throw Exception('Update failed: ${json['error']}');
    }
  }
}
