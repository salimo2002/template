import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/company_services.dart';
import 'package:template/cubit/imei%20cubit/imei_status.dart';

class ImeiCubit extends Cubit<ImeiStatus> {
  ImeiCubit() : super(ImeiInitState());
  List<String> devices = [];
  void deletDevice({required String imei, required int comId}) async {
    emit(ImeiLoadingState());
    try {
      String message = await CompanyServices.deleteDevice(
        comId: comId,
        imei: imei,
      );
      emit(ImeiSuccessState(message, devices: devices));
    } catch (e) {
      emit(ImeiFaliureState(errorMessage: e.toString()));
    }
  }

  void getDevices({required int comId}) async {
    emit(ImeiLoadingState());
    try {
      devices = await CompanyServices.getCompanyDevices(comId: comId);
      emit(ImeiSuccessState('', devices: devices));
    } catch (e) {
      emit(ImeiFaliureState(errorMessage: e.toString()));
    }
  }
}
