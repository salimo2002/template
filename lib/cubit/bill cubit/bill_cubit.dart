import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/bill_service.dart';
import 'package:template/cubit/bill%20cubit/bill_status.dart';
import 'package:template/models/bill_details_model.dart';
import 'package:template/models/bill_model.dart';

class BillCubit extends Cubit<BillStatus> {
  BillCubit() : super(InitStateBill());
  List<dynamic> resultBill = [];
  List<dynamic> resultBillDetails = [];
  List<BillModel> bill = [];
  List<BillDetailsModel> billDetails = [];

  Future<void> fetchBills({bool isRefresh = false}) async {
    if (!isRefresh) {
      emit(LoadingStateBill());
    }
    try {
      bill = [];
      resultBill = await BillServices.fetchAll();
      for (var element in resultBill) {
        bill.add(BillModel.fromJson(element));
      }
      emit(SuccessStateBill(bill: bill));
    } catch (e) {
      emit(FaliureStateBill(errorMessage: e.toString()));
    }
  }

  Future<void> billDeletById({required int id}) async {
    emit(LoadingStateBill());
    try {
      await BillServices.deleteBill(id);
      fetchBills(isRefresh: true);
    } catch (e) {
      emit(FaliureStateBill(errorMessage: e.toString()));
    }
  }

  Future<void> insertBill(BillModel bill, BillDetailsModel billDetails) async {
    try {
      emit(LoadingStateBill());
      await BillServices.addBillWithDetails(bill: bill, details: [billDetails]);
      fetchBills(isRefresh: true);
    } catch (e) {
      emit(FaliureStateBill(errorMessage: e.toString()));
    }
  }
}
