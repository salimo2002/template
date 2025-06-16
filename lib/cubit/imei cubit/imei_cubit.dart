import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/company_services.dart';
import 'package:template/cubit/imei%20cubit/imei_status.dart';

class ImeiCubit extends Cubit<ImeiStatus> {
  ImeiCubit() : super(ImeiInitState());
  List<String> devices = [];
  List<String> users = [];
  Map<String, String> result = {};
  void deletDevice({required String imei, required int comId,required userName}) async {
    emit(ImeiLoadingState());
    try {
      String message = await CompanyServices.deleteDevice(
        comId: comId,
        imei: imei,
        userName: userName
      );
      emit(ImeiSuccessState(message, devices: devices, users: users));
    } catch (e) {
      emit(ImeiFaliureState(errorMessage: e.toString()));
    }
  }

  Future<void> getDevices({required int comId}) async {
    emit(ImeiLoadingState());
    try {
      result = await CompanyServices.getCompanyDevices(comId: comId);
      devices = result.keys.toList();
      users = result.values.toList();
      emit(ImeiSuccessState('', devices: devices, users: users));
    } catch (e) {
      emit(ImeiFaliureState(errorMessage: e.toString()));
    }
  }
}
