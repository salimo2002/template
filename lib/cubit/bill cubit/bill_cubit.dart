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
  List result = [];
  Future<void> fetchMovementBills({
    required String databaseName,
    required String dateFrom,
    required String dateTo,
    required String matId,
  }) async {
    emit(LoadingStateBill());
    try {
      bill = [];
      billDetails = [];
      result = await BillServices.fetchMovementBills(
        databaseName: databaseName,
        dateFrom: dateFrom,
        dateTo: dateTo,
        matId: matId,
      );

      for (var element in result) {
        bill.add(BillModel.fromJson(element));
        for (var element2 in element['details']) {
          billDetails.add(BillDetailsModel.fromJson(element2));
        }
      }
      log(bill.toString());
      log('----------------------------------------');
      log(billDetails.toString());
      emit(SuccessStateBill(bill: bill));
    } catch (e) {
      emit(FaliureStateBill(errorMessage: e.toString()));
    }
  }

  Future<void> fetchBills({
    bool isRefresh = false,
    bool includeDetails = true,
  }) async {
    if (!isRefresh) emit(LoadingStateBill());

    try {
      bill = [];
      billDetails = [];
      resultBill = await BillServices.fetchBillss();

      for (var element in resultBill) {
        bill.add(BillModel.fromJson(element));
        log(element.toString());
      }

      if (includeDetails) {
        resultBillDetails = await BillServices.fetchBillDetails();
        for (var element in resultBillDetails) {
          billDetails.add(BillDetailsModel.fromJson(element));
        }
      }
      log('الفواتير كويسة');
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

  Future<void> insertBill(
    BillModel bill,
    List<BillDetailsModel> billDetails,
  ) async {
    try {
      emit(LoadingStateBill());
      await BillServices.addBillWithDetails(bill: bill, details: billDetails);
      fetchBills(isRefresh: true);
    } catch (e) {
      log(e.toString());
      emit(FaliureStateBill(errorMessage: e.toString()));
    }
  }

  Future<void> updateBill(
    BillModel bill,
    List<BillDetailsModel> billDetails,
  ) async {
    try {
      emit(LoadingStateBill());
      final result = await BillServices.updateBillWithDetails(
        bill: bill,
        details: billDetails,
      );
      if (result['success'] == true) {
        await fetchBills(isRefresh: true);
      } else {
        emit(
          FaliureStateBill(
            errorMessage: result['message'] ?? 'فشل في تعديل الفاتورة',
          ),
        );
      }
    } catch (e) {
      log('خطأ في updateBill: $e');
      emit(FaliureStateBill(errorMessage: e.toString()));
    }
  }
}
