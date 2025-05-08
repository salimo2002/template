import 'package:template/models/account_model.dart';

abstract class AccountsStatusAccounts {}

class InitStateAccounts extends AccountsStatusAccounts {}

class LoadingStateAccounts extends AccountsStatusAccounts {}

class SuccessStateAccounts extends AccountsStatusAccounts {
  final List<AccountModel> accounts;
  SuccessStateAccounts({required this.accounts});
}

class FaliureStateAccounts extends AccountsStatusAccounts {
  final String errorMessage;

  FaliureStateAccounts({required this.errorMessage});
}
