import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/models/account_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/custom_snack_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/invoice_review_view.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/invoice%20details%20view/radio_menu_buttons.dart';
import 'package:template/widgets/invoice%20details%20view/text_field_date.dart';
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
  bool isToDay = false;
  bool canRead = false;
  String? selectedBillType;

  Color color3 = kWhite;
  Color textColor3 = kBlueAccent;
  TextEditingController date1Controler = TextEditingController();
  TextEditingController date2Controler = TextEditingController();
  FocusNode date1 = FocusNode();
  FocusNode date2 = FocusNode();

  final List<Map<String, String>> billTypes = [
    {'label': 'فواتير المشتريات', 'value': 'buy'},
    {'label': 'فواتير المبيعات', 'value': 'sell'},
    {'label': 'فواتير مردود المشتريات', 'value': 'undo_buy'},
    {'label': 'فواتير مردود المبيعات', 'value': 'undo_sell'},
    {'label': 'فواتير  طلبات', 'value': 'order'},
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
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: kRed,
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
                        SizedBox(height: 20),
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 11),
                              child: ContainerFields(
                                children: [
                                  CustomContainer(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: const Padding(
                                        padding: EdgeInsets.all(1),
                                        child: RadioMenuButtons(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              child: Text(
                                ': نمط الدفع',
                                style: FontStyleApp.blackCustom18.copyWith(
                                  backgroundColor: kWhite,
                                  color: kBlueAccent,
                                  fontStyle: FontStyle.normal,
                                  fontSize: getResponsiveText(context, 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            SizedBox(height: 15),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              child: TextFieldDate(
                                canRead: canRead,
                                date: date1Controler,
                                hoursOrYear: true,
                                label: 'من تاريخ',
                              ),
                            ),
                            SizedBox(height: 15),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              child: TextFieldDate(
                                canRead: canRead,
                                date: date2Controler,
                                hoursOrYear: true,
                                label: 'الى تاريخ',
                              ),
                            ),
                          ],
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
      ),
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

  void navigatorToInvoiceReview() async {
    if (globalKey.currentState!.validate()) {
      final date1 = date1Controler.text.trim();
      final date2 = date2Controler.text.trim();

      if (date1.isEmpty || date2.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(context, 'الرجاء اختيار التاريخين معًا', kRed),
        );
        return;
      }

      final fromDate = DateTime.tryParse(date1);
      final toDate = DateTime.tryParse(date2);

      if (fromDate == null || toDate == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(customSnackBar(context, 'تاريخ غير صالح', kRed));
        return;
      }

      if (fromDate.isAfter(toDate)) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(context, 'التاريخ الأول أحدث من الثاني', kRed),
        );
        return;
      }

      final isSingleDay = date1 == date2 || isToDay;

      // ✅ نضيف الوقت للبحث في اليوم الكامل
      final fromDateFormatted = '$date1 00:00:00';
      final toDateFormatted = '$date2 23:59:59';

      final billCubit = context.read<BillCubit>();

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      try {
        await billCubit.fetchFilteredBills(
          dateFrom: fromDateFormatted,
          dateTo: toDateFormatted,
          accId: accountController.text.isNotEmpty ? accId : null,
          bilKind: selectedBillType,
        );

        Navigator.pop(context); // لإغلاق Dialog التحميل

        Navigator.pushNamed(
          context,
          InvoiceReviewView.id,
          arguments: {
            'title':
                billTypes.firstWhere(
                  (element) => element['value'] == selectedBillType,
                  orElse: () => {'label': ''},
                )['label'] ??
                '',
            'billType': selectedBillType ?? '',
            'nameAcuont': accountController.text.isNotEmpty ? accId : null,
            'dateTime': DateTime.now().toIso8601String(),
            'isMonth': isSingleDay,
          },
        );
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(customSnackBar(context, 'فشل تحميل الفواتير: $e', kRed));
      }
    }
  }
}
