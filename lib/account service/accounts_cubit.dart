import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/account_service%20.dart';
import 'package:template/account%20service/accounts_status.dart';
import 'package:template/models/account_model.dart';

class AccountsCubit extends Cubit<AccountsStatusAccounts> {
  AccountsCubit() : super(InitStateAccounts());
  List<dynamic> resultMaterial = [];
  List<AccountModel> accounts = [];

  Future<void> fetchAccounts({bool isRefresh = false}) async {
    if (!isRefresh) {
      emit(LoadingStateAccounts());
    }
    try {
      accounts = [];
      resultMaterial = await AccountService.fetchAccounts();
      for (var element in resultMaterial) {
        accounts.add(AccountModel.fromJson(element));
      }
      emit(SuccessStateAccounts(accounts: accounts));
    } on Exception catch (e) {
      emit(FaliureStateAccounts(errorMessage: e.toString()));
    }
  }

  Future<void> insertAccounts(AccountModel accountModel) async {
    try {
      emit(LoadingStateAccounts());
      await AccountService.createAccount(account: accountModel);
      await fetchAccounts(isRefresh: true);
      emit(SuccessStateAccounts(accounts: accounts));
    } catch (e) {
      emit(FaliureStateAccounts(errorMessage: e.toString()));
    }
  }

  Future<void> updateAccounts(AccountModel accountModel) async {
    try {
      emit(LoadingStateAccounts());
      await AccountService.updateAccount(
        account: accountModel,
        accId: accountModel.curId,
      );
      await fetchAccounts(isRefresh: true);
      emit(SuccessStateAccounts(accounts: accounts));
    } catch (e) {
      emit(FaliureStateAccounts(errorMessage: e.toString()));
    }
  }

  //تعديل ملف php لحذف عن طريق رقم الحساب
  Future<void> deleteAccount(AccountModel accountModel) async {
    try {
      emit(LoadingStateAccounts());
      await AccountService.deleteAccount(accId: accountModel.accNumber);
      await fetchAccounts(isRefresh: true);
      emit(SuccessStateAccounts(accounts: accounts));
    } catch (e) {
      emit(FaliureStateAccounts(errorMessage: e.toString()));
    }
  }
}
