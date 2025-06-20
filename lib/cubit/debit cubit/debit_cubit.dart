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
Future<void> fetchDebits() async {
  try {
    emit(LoadingStateDebit());
    
    final fetchedDebits = await DebitService.fetchDebits();
    
 
      debits = fetchedDebits;
       for (var i = 0; i < debits.length; i++) {
         log(debits[i].debAmount.toString());
       }
      emit(LoadedDebitsState(debits: debits));
  } catch (e, stackTrace) {
    log("حدث خطأ أثناء جلب البيانات", error: e, stackTrace: stackTrace);
    emit(FaliureStateDebit(errorMessage: "فشل في جلب السندات: ${e.toString()}"));
  }
}
}