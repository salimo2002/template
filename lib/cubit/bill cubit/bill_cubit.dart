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

  Future<void> fetchMovementBills({
    required String databaseName,
    required String dateFrom,
    required String dateTo,
    required String matId,
  }) async {
    List result = [];
    List<BillModel> bills = [];
    List<BillDetailsModel> bDetails = [];

    emit(LoadingStateBill());
    try {
      result = await BillServices.fetchMovementBills(
        dateFrom: dateFrom,
        dateTo: dateTo,
        matId: matId,
      );

      for (var element in result) {
        bills.add(BillModel.fromJson(element));
        for (var element2 in element['details']) {
          bDetails.add(BillDetailsModel.fromJson(element2));
        }
      }
      log(bills[0].accId.toString());
      log('----------------------------------------');
      log(bDetails[0].matId.toString());
      emit(SuccessStateBill(bill: bills, bDeatails: bDetails));
    } catch (e) {
      log(e.toString());
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

      emit(SuccessStateBill(bill: bill, bDeatails: []));
    } catch (e) {
      emit(FaliureStateBill(errorMessage: e.toString()));
    }
  }

  Future<void> fetchFilteredBills({
    required String dateFrom,
    required String dateTo,
    int? accId,
    String? bilKind,
  }) async {
    emit(LoadingStateBill());
    try {
      bill = [];
      billDetails = [];
      final result = await BillServices.fetchBillsWithDetailsFiltered(
        dateFrom: dateFrom,
        dateTo: dateTo,
        accId: accId,
        bilKind: bilKind,
      );

      for (var item in result) {
        final billModel = BillModel.fromJson(item);
        bill.add(billModel);

        final detailsList = item['details'] as List<dynamic>;
        for (var det in detailsList) {
          billDetails.add(BillDetailsModel.fromJson(det));
        }
      }

      emit(SuccessStateBill(bill: bill, bDeatails: []));
    } catch (e) {
      log('fetchFilteredBills Error: $e');
      emit(FaliureStateBill(errorMessage: e.toString()));
    }
  }

  Future<void> billDeletById({required int id}) async {
    emit(LoadingStateBill());
    try {
      await BillServices.deleteBill(id);
      emit(SuccessStateBill(bill: [], bDeatails: []));
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
      emit(SuccessStateBill(bill: [], bDeatails: [])); /////////////edit
    } catch (e) {
      log(e.toString());
      emit(FaliureStateBill(errorMessage: e.toString()));
    }
  }

  /// تعديل فاتورة مع تفاصيلها
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
      emit(SuccessStateBill(bill: [], bDeatails: []));
      if (result['success'] == true) {
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
