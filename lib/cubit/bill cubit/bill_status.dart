import 'package:template/models/bill_details_model.dart';
import 'package:template/models/bill_model.dart';

abstract class BillStatus {}

class InitStateBill extends BillStatus {}

class LoadingStateBill extends BillStatus {}

class SuccessStateBill extends BillStatus {
  final List<BillModel> bill;
  final List<BillDetailsModel> bDeatails;
  SuccessStateBill({required this.bill,required this.bDeatails});
}

class FaliureStateBill extends BillStatus {
  final String errorMessage;

  FaliureStateBill({required this.errorMessage});
}
