import 'package:template/models/company_model.dart';

abstract class CompanyStatus {}

class CompanyInitState extends CompanyStatus {}

class CompanySuccesState extends CompanyStatus {
  final CompanyModel company;
  final String message;
  CompanySuccesState({required this.company, required this.message});
}

class CompanyFaliureState extends CompanyStatus {
  final String errorMessage;

  CompanyFaliureState({required this.errorMessage});
}

class CompanyLoadingState extends CompanyStatus {}
