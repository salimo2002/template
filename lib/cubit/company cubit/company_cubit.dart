import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/company_services.dart';
import 'package:template/cubit/company%20cubit/company_status.dart';
import 'package:template/models/company_model.dart';

class CompanyCubit extends Cubit<CompanyStatus> {
  CompanyCubit() : super(CompanyInitState());
  late CompanyModel comp;
  String er = '';
  void checkCompany({
    required String comName,
    required String comSerial,
  }) async {
    emit(CompanyLoadingState());
    try {
      var result = await CompanyServices.checkCompany(
        comSerial: comSerial,
        companyName: comName,
      );
      er = result['message'];
      comp = CompanyModel.fromJson(result['data']);
      emit(CompanySuccesState(company: comp, message: result['message']));
    } catch (e) {
      emit(CompanyFaliureState(errorMessage: er));
    }
  }
}
