import 'package:template/models/acconts_get_perint_id_zero.dart';
import 'package:template/models/account_model.dart';

abstract class AccountsStatusAccounts {}

class InitStateAccounts extends AccountsStatusAccounts {}

class LoadingStateAccounts extends AccountsStatusAccounts {}

class SuccessStateAccounts extends AccountsStatusAccounts {
  final List<AccountModel> accounts;
  final List<ParentAccountsModel> parentsAccounts;
  SuccessStateAccounts({required this.accounts, required this.parentsAccounts});
}

class FaliureStateAccounts extends AccountsStatusAccounts {
  final String errorMessage;

  FaliureStateAccounts({required this.errorMessage});
}
