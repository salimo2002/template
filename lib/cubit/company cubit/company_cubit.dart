import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/company_services.dart';
import 'package:template/cubit/company%20cubit/company_status.dart';
import 'package:template/models/company_model.dart';

class CompanyCubit extends Cubit<CompanyStatus> {
  CompanyCubit() : super(CompanyInitState());
  static late CompanyModel comp;
  String message = '';
  void verifyAndActivateDevice({
    required String companyName,
    required String serialKey,
    required String imei,
    required String userName,
  }) async {
    emit(CompanyLoadingState());
    try {
      Map<String, dynamic> companyDetails =
          await CompanyServices.verifyAndActivateDevice(
            companyName: companyName,
            serialKey: serialKey,
            imei: imei,
            userName: userName
          );
      message = companyDetails['message'];
      comp = CompanyModel.fromJson(companyDetails['data']);
      emit(CompanySuccesState(company: comp, message: message));
    } catch (e) {
      emit(CompanyFaliureState(errorMessage: e.toString()));
    }
  }
}
