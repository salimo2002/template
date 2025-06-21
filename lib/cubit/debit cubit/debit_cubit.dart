import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/debit_service.dart';
import 'package:template/cubit/debit%20cubit/debit_status.dart';
import 'package:template/models/debit_model.dart';

class DebitCubit extends Cubit<DebitStatus> {
  DebitCubit() : super(InitStateDebit());

  List<DebitModel> debits = [];

  Future<void> insertDebit(DebitModel debit) async {
    try {
      emit(LoadingStateDebit());
      await DebitService.addDebit(debit: debit);
      log('تمت اضافة السند');

      debits.add(debit);
      emit(SuccessStateDebit(debit: debit));
    } catch (e) {
      emit(FaliureStateDebit(errorMessage: e.toString()));
    }
  }

  Future<void> fetchDebits({String? dateFrom, String? dateTo}) async {
    try {
      emit(LoadingStateDebit());

      final fetchedDebits = await DebitService.fetchDebits(
        dateFrom: dateFrom,
        dateTo: dateTo,
      );

      debits = fetchedDebits;

      for (var debit in debits) {
        log(debit.debAmount.toString());
      }

      emit(LoadedDebitsState(debits: debits));
    } catch (e, stackTrace) {
      log("حدث خطأ أثناء جلب البيانات", error: e, stackTrace: stackTrace);
      emit(
        FaliureStateDebit(errorMessage: "فشل في جلب السندات: ${e.toString()}"),
      );
    }
  }

  Future<void> deleteDebit(int debId) async {
    try {
      emit(LoadingStateDebit());

      await DebitService.deleteDebit(debId: debId);

      debits.removeWhere((debit) => debit.debId == debId);

      emit(LoadedDebitsState(debits: debits));
    } catch (e, stackTrace) {
      log("فشل في حذف السند", error: e, stackTrace: stackTrace);
      emit(
        FaliureStateDebit(errorMessage: "فشل في حذف السند: ${e.toString()}"),
      );
    }
  }

  Future<void> updateDebit(DebitModel debit) async {
    try {
      log('updateDebit called with id: ${debit.debId}');
      emit(LoadingStateDebit());
      await DebitService.updateDebit(debit: debit);
      // تحديث القائمة المحلية لو موجودة
      int index = debits.indexWhere((d) => d.debId == debit.debId);
      if (index != -1) {
        debits[index] = debit;
      }
      emit(SuccessStateDebit(debit: debit));
    } catch (e, stackTrace) {
      log('Error in updateDebit: $e', stackTrace: stackTrace);
      emit(FaliureStateDebit(errorMessage: e.toString()));
    }
  }
}
