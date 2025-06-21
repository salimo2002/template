import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:template/cubit/company%20cubit/company_cubit.dart';
import 'package:template/models/setting_model.dart';

class SettingService {
  static const String _baseUrl = 'https://www.itech-sy.com/api';
  static final String _urlFetchSetting = '$_baseUrl/fetch_setting.php';

  static Future<SettingModel> fetchSettings() async {
    final url = Uri.parse(_urlFetchSetting);

    final response = await http.post(
      url,
      body: {'database_name': CompanyCubit.comp.dataBase},
    );

    if (response.statusCode != 200) {
      throw Exception('فشل في الاتصال بالسيرفر');
    }

    try {
      final Map<String, dynamic> data = jsonDecode(response.body);
      SettingModel settingModel = SettingModel.fromJson(data);
      return settingModel;
    } catch (e) {
      throw Exception('فشل في تحليل البيانات: $e');
    }
  }

  static final String _urlUpdateSetting = '$_baseUrl/update_setting.php';

  static Future<void> updateSettings({
    required String databaseName,
    required String settingId,
    required String buyPrice,
    required String sellPrice,
    required String undoBuyPrice,
    required String undoSellPrice,
    required String mainAccount,
  }) async {
    final url = Uri.parse(_urlUpdateSetting);

    final response = await http.post(
      url,
      body: {
        'database_name': CompanyCubit.comp.dataBase,
        'BUY_PRICE': buyPrice,
        'SELL_PRICE': sellPrice,
        'UNDO_BUY_PRICE': undoBuyPrice,
        'UNDO_SELL_PRICE': undoSellPrice,
        'MAIN_ACCOUNT': mainAccount,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('فشل في الاتصال بالسيرفر');
    }

    final responseBody = response.body.trim();
    if (responseBody != 'success') {
      throw Exception('فشل في تعديل الإعدادات: $responseBody');
    }
  }
}
