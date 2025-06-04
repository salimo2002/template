import 'package:template/models/debit_model.dart';

abstract class DebitStatus {}

class InitStateDebit extends DebitStatus {}

class LoadingStateDebit extends DebitStatus {}

class SuccessStateDebit extends DebitStatus {
  final DebitModel debit;
  SuccessStateDebit({required this.debit});
}

class FaliureStateDebit extends DebitStatus {
  final String errorMessage;

  FaliureStateDebit({required this.errorMessage});
}
