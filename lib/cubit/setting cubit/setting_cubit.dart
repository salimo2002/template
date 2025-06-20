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
    } catch (e) {}
  }

  void updateSetting() {}
}
