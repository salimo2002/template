import 'package:template/models/debit_model.dart';

abstract class DebitStatus {}

class InitStateDebit extends DebitStatus {}

class LoadingStateDebit extends DebitStatus {}

class SuccessStateDebit extends DebitStatus {
  final DebitModel debit;
  SuccessStateDebit({required this.debit});
}
class LoadedDebitsState extends DebitStatus {
  final List<DebitModel> debits;
  LoadedDebitsState({required this.debits});
}

class FaliureStateDebit extends DebitStatus {
  final String errorMessage;

  FaliureStateDebit({required this.errorMessage});
}
