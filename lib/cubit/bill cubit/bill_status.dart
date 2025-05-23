import 'package:template/models/bill_model.dart';

abstract class BillStatus {}

class InitStateBill extends BillStatus {}

class LoadingStateBill extends BillStatus {}

class SuccessStateBill extends BillStatus {
  final List<BillModel> bill;
  SuccessStateBill({required this.bill});
}

class FaliureStateBill extends BillStatus {
  final String errorMessage;

  FaliureStateBill({required this.errorMessage});
}
