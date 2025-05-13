import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/Service/acconts_Get_perint_id_zero_service.dart';
import 'package:template/Service/account_service%20.dart';
import 'package:template/account%20cubit/accounts_status.dart';
import 'package:template/models/acconts_get_perint_id_zero.dart';
import 'package:template/models/account_model.dart';

class AccountsCubit extends Cubit<AccountsStatusAccounts> {
  AccountsCubit() : super(InitStateAccounts());
  List<dynamic> resultAccounts = [];
  List<AccountModel> accounts = [];
  List<dynamic> resultParentsAccounts = [];
  List<ParentAccountsModel> parentsAccounts = [];
  Future<void> fetchAccounts({bool isRefresh = false}) async {
    if (!isRefresh) {
      emit(LoadingStateAccounts());
    }
    try {
      accounts = [];

      resultParentsAccounts =
          await ParentAccountsService.accontsGetPerintIdZero();

      for (var element in resultParentsAccounts) {
        parentsAccounts.add(ParentAccountsModel.fromJson(element));
      }
      resultAccounts = await AccountService.fetchAccounts();
      for (var element in resultAccounts) {
        accounts.add(AccountModel.fromJson(element));
      }

      emit(
        SuccessStateAccounts(
          accounts: accounts,
          parentsAccounts: parentsAccounts,
        ),
      );
    } on Exception catch (e) {
      emit(FaliureStateAccounts(errorMessage: e.toString()));
    }
  }

  Future<void> insertAccounts(AccountModel accountModel) async {
    try {
      emit(LoadingStateAccounts());
      await AccountService.createAccount(account: accountModel);
      await fetchAccounts(isRefresh: true);
      emit(SuccessStateAccounts(accounts: accounts, parentsAccounts: []));
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
      emit(SuccessStateAccounts(accounts: accounts, parentsAccounts: []));
    } catch (e) {
      emit(FaliureStateAccounts(errorMessage: e.toString()));
    }
  }

  //تعديل ملف php لحذف عن طريق رقم الحساب
  Future<void> deleteAccount(int accId) async {
    try {
      emit(LoadingStateAccounts());
      await AccountService.deleteAccount(accId: accId);
      await fetchAccounts(isRefresh: true);
      emit(SuccessStateAccounts(accounts: accounts, parentsAccounts: []));
    } catch (e) {
      emit(FaliureStateAccounts(errorMessage: e.toString()));
    }
  }
}
