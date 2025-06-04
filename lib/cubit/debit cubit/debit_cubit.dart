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

      debits.add(debit);

      emit(SuccessStateDebit(debit: debit));
    } catch (e) {
      emit(FaliureStateDebit(errorMessage: e.toString()));
    }
  }
}
