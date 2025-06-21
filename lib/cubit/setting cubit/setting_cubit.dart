import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/setting_service.dart';
import 'package:template/cubit/setting%20cubit/setting_state.dart';
import 'package:template/models/setting_model.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(InitSettingState());
  late SettingModel settingModel;
  void fetchSetting() {
    try {
      emit(LoadingtSettingState());
      settingModel = SettingModel.fromJson(
        SettingService.fetchSettings(databaseName: 'itechsy_test'),
      );
      emit(SuccesSettingState());
    } catch (e) {
      emit(FaliureSettingState());
    }
  }

  void updateSetting({
    required String databaseName,
    required String buyPrice,
    required String sellPrice,
    required String undoBuyPrice,
    required String undoSellPrice,
    required String mainAccount,
  }) {
    try {
      emit(LoadingtSettingState());
      SettingService.updateSettings(
        databaseName: databaseName,
        buyPrice: buyPrice,
        sellPrice: sellPrice,
        undoBuyPrice: undoBuyPrice,
        undoSellPrice: undoSellPrice,
        mainAccount: mainAccount,
      );
      emit(SuccesSettingState());
    } catch (e) {
      emit(FaliureSettingState());
    }
  }
}
