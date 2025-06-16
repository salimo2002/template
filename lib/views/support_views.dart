import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/models/account_model.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/widgets/invoice%20details%20view/comments_text_field.dart';
import 'package:template/widgets/invoice%20details%20view/text_field_date.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_save.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class SupportViews extends StatefulWidget {
  const SupportViews({super.key});
  static String id = 'SupportViews';

  @override
  State<SupportViews> createState() => _SupportViewsState();
}

class _SupportViewsState extends State<SupportViews> {
  final FocusNode _focusNode0 = FocusNode();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();

  final TextEditingController _nameAccountController = TextEditingController();
  final TextEditingController _nameAccountController2 = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  late String documentType;

  List<AccountModel> debtorSearchResults = [];
  List<AccountModel> creditorSearchResults = [];
  bool isSearchingDebtor = false;
  bool isSearchingCreditor = false;
  @override
  void didChangeDependencies() {
    documentType = ModalRoute.of(context)!.settings.arguments as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'سند', showIcons: false),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ContainerFields(
                        children: [
                          TextFieldDate(
                            canRead: false,
                            date: _dateController,
                            hoursOrYear: true,
                            label: 'التاريخ',
                          ),
                          CommentsTextField(
                            width: MediaQuery.sizeOf(context).width * 0.75,
                            focusNode: _focusNode3,
                            maxLines: 4,
                            label: 'ملاحظة',
                            controller: _noteController,
                          ),
                          const Divider(),
                          CustomTextField(
                            onChanged:
                                (query) => searchAccount(query, isDebtor: true),
                            suffixIcon: const SizedBox(width: 40, height: 40),
                            hintText: 'الحساب المدين',
                            controller: _nameAccountController,
                            focusNode: _focusNode0,
                          ),
                          if (isSearchingDebtor)
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: SearchResultsList(
                                results: debtorSearchResults,
                                onSelect: (account) {
                                  setState(() {
                                    _nameAccountController.text =
                                        account.accName;
                                    isSearchingDebtor = false;
                                  });
                                },
                              ),
                            ),
                          CustomTextField(
                            onChanged:
                                (query) =>
                                    searchAccount(query, isDebtor: false),
                            suffixIcon: const SizedBox(width: 40, height: 40),
                            hintText: 'حساب الدائن',
                            controller: _nameAccountController2,
                            focusNode: _focusNode2,
                          ),
                          if (isSearchingCreditor)
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: SearchResultsList(
                                results: creditorSearchResults,
                                onSelect: (account) {
                                  setState(() {
                                    _nameAccountController2.text =
                                        account.accName;
                                    isSearchingCreditor = false;
                                  });
                                },
                              ),
                            ),
                          CustomTextField(
                            keyType: TextInputType.numberWithOptions(),
                            hintText: 'المبلغ',
                            controller: _amountController,
                            focusNode: _focusNode,
                          ),
                        ],
                      ),
                    ],
                  ),
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
                  CustomButtonSave(label: 'حفظ', onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchAccount(String query, {required bool isDebtor}) {
    if (query.isEmpty) {
      setState(() {
        if (isDebtor) {
          debtorSearchResults = [];
          isSearchingDebtor = false;
        } else {
          creditorSearchResults = [];
          isSearchingCreditor = false;
        }
      });
      return;
    }

    final accounts = context.read<AccountsCubit>().accounts;
    final results =
        accounts.where((account) {
          return account.accName.toLowerCase().contains(query.toLowerCase());
        }).toList();

    setState(() {
      if (isDebtor) {
        debtorSearchResults = results;
        isSearchingDebtor = true;
      } else {
        creditorSearchResults = results;
        isSearchingCreditor = true;
      }
    });
  }
}

class SearchResultsList extends StatelessWidget {
  final List<AccountModel> results;
  final void Function(AccountModel) onSelect;

  const SearchResultsList({
    super.key,
    required this.results,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: results.length,
          itemBuilder: (context, index) {
            final account = results[index];
            return ListTile(
              title: Text(account.accName),
              subtitle: Text(account.accKind.toString()),
              onTap: () => onSelect(account),
            );
          },
        ),
      ),
    );
  }
}
