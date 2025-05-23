import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/bill_service.dart';
import 'package:template/cubit/bill%20cubit/bill_status.dart';
import 'package:template/models/bill_model.dart';

class BillCubit extends Cubit<BillStatus> {
  BillCubit() : super(InitStateBill());
  List<dynamic> resultBill = [];
  List<BillModel> bill = [];

  Future<void> fetchBill() async {
    emit(LoadingStateBill());
    try {
      bill = [];
      resultBill = await BillServices.fetchAll();
      for (var element in resultBill) {
        bill.add(BillModel.fromJson(element));
      }
      emit(SuccessStateBill(bill: bill));
    } on Exception catch (e) {
      emit(FaliureStateBill(errorMessage: e.toString()));
    }
  }

  Future<void> billDeletById({required int id}) async {
    try {
      emit(LoadingStateBill());
      await BillServices.deleteBill(id);
      resultBill = await BillServices.fetchAll();
      bill = resultBill.map((e) => BillModel.fromJson(e)).toList();
      emit(SuccessStateBill(bill: bill));
    } catch (e) {
      emit(FaliureStateBill(errorMessage: e.toString()));
    }
  }

  // Future<void> updateCategory(CategoryModel category) async {
  //   try {
  //     emit(LoadingStateCategory());
  //     await CategoryServices.updateCategory(category);
  //     resultCategories = await CategoryServices.fetchCategory();
  //     categories =
  //         resultCategories.map((e) => CategoryModel.fromJson(e)).toList();
  //     emit(SuccessStateCategory(categories: categories));
  //   } catch (e) {
  //     emit(FaliureStateCategory(errorMessage: e.toString()));
  //   }
  // }

  // Future<void> insertCategory(CategoryModel category) async {
  //   try {
  //     emit(LoadingStateCategory());
  //     await CategoryServices.addCategory(category);
  //     resultCategories = await CategoryServices.fetchCategory();
  //     categories =
  //         resultCategories.map((e) => CategoryModel.fromJson(e)).toList();
  //     emit(SuccessStateCategory(categories: categories));
  //   } catch (e) {
  //     emit(FaliureStateCategory(errorMessage: e.toString()));
  //   }
  // }
}
