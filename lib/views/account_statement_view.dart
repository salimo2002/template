import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/models/account_model.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/views/detailed_account_statement_views.dart';
import 'package:template/views/support_views.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_save.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class AccountStatementView extends StatefulWidget {
  const AccountStatementView({super.key});
  static String id = 'AccountStatementView';
  @override
  State<AccountStatementView> createState() => _AccountStatementViewState();
}

class _AccountStatementViewState extends State<AccountStatementView> {
  List<AccountModel> searchResults = [];
  bool isSearching = false;
  final FocusNode _focusNode = FocusNode();

  final TextEditingController accountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'كشف حساب',
        showIcons: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: ContainerFields(
                    children: [
                      CustomTextField(
                        onChanged: (query) => searchAccount(query),
                        suffixIcon: const SizedBox(width: 40, height: 40),
                        hintText: 'الحساب',
                        controller: accountController,
                        focusNode: _focusNode,
                      ),
                      if (isSearching)
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SearchResultsList(
                            results: searchResults,
                            onSelect: (account) {
                              setState(() {
                                accountController.text = account.accName;
                                isSearching = false;
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButtonSave(
                      label: 'إلغاء',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    CustomButtonSave(
                      label: 'التالي',
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          DetailedAccountStatementView.id,
                          arguments: accountController,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchAccount(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
        isSearching = false;
      });
      return;
    }

    setState(() {
      isSearching = true;
    });

    final accounts = context.read<AccountsCubit>().accounts;
    final results =
        accounts.where((account) {
          return account.accName.toLowerCase().contains(query.toLowerCase());
        }).toList();

    setState(() {
      searchResults = results;
    });
  }
}
