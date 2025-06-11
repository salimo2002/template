import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/models/account_model.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/views/detailed_account_statement_views.dart';
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
  int accIdElement = 0;

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
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            constraints: const BoxConstraints(maxHeight: 250),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: searchResults.length,
                                itemBuilder: (context, index) {
                                  final account = searchResults[index];
                                  return ListTile(
                                    title: Text(
                                      account.accName,
                                      textAlign: TextAlign.right,
                                    ),
                                    subtitle: Text(
                                      account.accKind.toString(),
                                      textAlign: TextAlign.right,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        accountController.text =
                                            account.accName;
                                        isSearching = false;
                                        searchResults = [];
                                        FocusScope.of(context).unfocus();
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
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
                        context.read<AccountsCubit>().accounts.forEach((
                          element,
                        ) {
                          if (element.accName == accountController.text) {
                            accIdElement = element.accID!;
                          }
                        });
                        Navigator.pushNamed(
                          context,
                          DetailedAccountStatementView.id,
                          arguments: accIdElement,
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
