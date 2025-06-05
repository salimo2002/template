import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/material%20cubit/material_cubit.dart';
import 'package:template/models/account_model.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/views/invoice_review_view.dart';
import 'package:template/views/support_views.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_save.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class MovementOfMatterView extends StatefulWidget {
  const MovementOfMatterView({super.key});
  static String id = 'MovementOfMatterView';
  @override
  State<MovementOfMatterView> createState() => _AccountStatementViewState();
}

class _AccountStatementViewState extends State<MovementOfMatterView> {
  List<AccountModel> searchResults = [];
  bool isSearching = false;
  final FocusNode _focusNode = FocusNode();
  int matId = 0;

  final TextEditingController materialController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'حركة مادة',
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
                        hintText: 'اسم المادة',
                        controller: materialController,
                        focusNode: _focusNode,
                      ),
                      if (isSearching)
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SearchResultsList(
                            results: searchResults,
                            onSelect: (account) {
                              setState(() {
                                materialController.text = account.accName;
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
                        context.read<MaterialCubit>().materials.forEach((
                          element,
                        ) {
                          if (element.materialName == materialController.text) {
                            matId = element.materialId;
                          }
                        });
                        Navigator.pushNamed(
                          context,
                          InvoiceReviewView.id,
                          arguments: 491,
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
