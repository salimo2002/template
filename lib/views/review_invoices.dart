import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/models/account_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/invoice_review_view.dart';
import 'package:template/widgets/Invoice%20review/filter_invoice_review.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/invoice%20details%20view/radio_menu_buttons.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_save.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class ReviewInvoices extends StatefulWidget {
  const ReviewInvoices({super.key});

  static String id = 'ReviewInvoices';

  @override
  State<ReviewInvoices> createState() => _ReviewInvoicesState();
}

class _ReviewInvoicesState extends State<ReviewInvoices> {
  DateTime? picked;
  final FocusNode _focusNode2 = FocusNode();
  final TextEditingController accountController = TextEditingController();

  List<AccountModel> searchResults = [];
  bool isSearching = false;
  late int accId;
  GlobalKey<FormState> globalKey = GlobalKey();
  bool isMonth = false;
  String? selectedBillType;

  Color color1 = kWhite;
  Color textColor1 = kBlueAccent;
  Color color2 = kWhite;
  Color textColor2 = kBlueAccent;
  Color color3 = kWhite;
  Color textColor3 = kBlueAccent;
  Color color4 = kWhite;
  Color textColor4 = kBlueAccent;

  final List<Map<String, String>> billTypes = [
    {'label': 'فواتير المشتريات', 'value': 'buy'},
    {'label': 'فواتير المبيعات', 'value': 'sell'},
    {'label': 'فواتير مردود المشتريات', 'value': 'undo_buy'},
    {'label': 'فواتير مردود المبيعات', 'value': 'undo_sell'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'استعراض فواتير',
        showIcons: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ContainerFields(
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'نوع الفاتورة',
                                  labelStyle: TextStyle(color: kBlueAccent),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: kBlueAccent,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: kBlueAccent,
                                      width: 1,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 2,
                                  ),
                                ),
                                value: selectedBillType,
                                items:
                                    billTypes.map((type) {
                                      return DropdownMenuItem<String>(
                                        value: type['value'],
                                        child: Text(type['label']!),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedBillType = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'اختر نوع الفاتورة';
                                  }
                                  return null;
                                },
                                iconEnabledColor: kBlueAccent,
                                dropdownColor: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 15),

                            CustomTextField(
                              onChanged: searchAccount,
                              suffixIcon: InkWell(
                                onTapDown: (details) {},
                                child: const Icon(
                                  Icons.more_vert,
                                  color: kBlueAccent,
                                  size: 25,
                                ),
                              ),
                              hintText: 'الحساب المتربط',
                              controller: accountController,
                              focusNode: _focusNode2,
                            ),

                            if (isSearching)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: 250,
                                  ),
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
                                            accId = account.accID!;
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
                          ],
                        ),
                        ContainerFields(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: kBlueAccent,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Text(
                                  'نمط الدفع',
                                  style: FontStyleApp.white18.copyWith(
                                    fontSize: getResponsiveText(context, 12),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomContainer(
                                borderRadius: BorderRadius.circular(15),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: const Padding(
                                    padding: EdgeInsets.all(1),
                                    child: RadioMenuButtons(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        FilterInvoiceReview(
                          onTapCustom: () {
                            setState(() {
                              picked = DateTime.now();
                              isMonth = false;
                            });
                          },
                          onTapMonth: () {
                            setState(() {
                              picked = null;
                              isMonth = false;
                            });
                          },
                          onTapDay: () {
                            setState(() {
                              isMonth = true;
                            });
                            selectDate(context);
                          },
                          onTapAll: () {
                            setState(() {
                              isMonth = false;
                            });
                            selectDate(context);
                          },
                        ),

                        const SizedBox(height: 20),

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
                                label: 'موافق',
                                onTap: () {
                                  navigatorToInvoiceReview();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> selectDate(BuildContext context) async {
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),
      initialDatePickerMode: isMonth ? DatePickerMode.year : DatePickerMode.day,
    );
  }

  void searchAccount(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        searchResults = [];
        isSearching = false;
      });
      return;
    }

    final accounts = context.read<AccountsCubit>().accounts;

    final results =
        accounts.where((account) {
          return account.accName.toLowerCase().contains(query.toLowerCase());
        }).toList();

    setState(() {
      searchResults = results;
      isSearching = results.isNotEmpty;
    });
  }

  void navigatorToInvoiceReview() {
    if (globalKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        InvoiceReviewView.id,
        arguments: {
          'title':
              billTypes.firstWhere(
                (element) => element['value'] == selectedBillType,
              )['label'] ??
              '',
          'billType': selectedBillType ?? '',
          'nameAcuont': accId,
          'dateTime':
              picked == null
                  ? ''
                  : isMonth
                  ? '${picked!.year}-${picked!.month}'
                  : '${picked!.year}-${picked!.month}-${picked!.day}',
          'isMonth': isMonth,
        },
      );
    }
  }
}
