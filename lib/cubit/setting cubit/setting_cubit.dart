import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/setting_service.dart';
import 'package:template/cubit/setting%20cubit/setting_state.dart';
import 'package:template/models/setting_model.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(InitSettingState());
  late SettingModel settingModel;
  void fetchSetting({bool isRefresh = false}) async {
    try {
      if (!isRefresh) {
        emit(LoadingtSettingState());
      }

      settingModel = await SettingService.fetchSettings();
      emit(SuccesSettingState());
    } catch (e) {
      emit(FaliureSettingState());
    }
  }

  void updateSetting({
    required String buyPrice,
    required String sellPrice,
    required String undoBuyPrice,
    required String undoSellPrice,
    required String mainAccount,
  }) async {
    try {
      emit(LoadingtSettingState());
      await SettingService.updateSettings(
        databaseName: 'itechsy_test',
        settingId: '1',
        buyPrice: buyPrice,
        sellPrice: sellPrice,
        undoBuyPrice: undoBuyPrice,
        undoSellPrice: undoSellPrice,
        mainAccount: mainAccount,
      );
      fetchSetting();
    } catch (e) {
      emit(FaliureSettingState());
    }
  }
}
