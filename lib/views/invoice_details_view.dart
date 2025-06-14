import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_status.dart';
import 'package:template/models/account_model.dart';
import 'package:template/models/bill_details_model.dart';
import 'package:template/models/bill_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/custom_snack_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/home_view.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/invoice%20details%20view/comments_text_field.dart';
import 'package:template/widgets/invoice%20details%20view/radio_menu_buttons.dart';
import 'package:template/widgets/invoice%20details%20view/text_field_date.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_save.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';
import 'package:template/widgets/new%20item%20view%20widgets/text_field_details.dart';

class InvoiceDetailsView extends StatefulWidget {
  const InvoiceDetailsView({super.key});
  static String id = 'InvoiceDetailsView';

  @override
  State<InvoiceDetailsView> createState() => _InvoiceDetailsViewState();
}

class _InvoiceDetailsViewState extends State<InvoiceDetailsView> {
  final TextEditingController date = TextEditingController();
  final TextEditingController hour = TextEditingController();
  final TextEditingController nameAccount = TextEditingController();
  final TextEditingController mainBox = TextEditingController();
  final TextEditingController countInvois = TextEditingController();
  final TextEditingController discount = TextEditingController();
  final TextEditingController totalInvois = TextEditingController();
  final TextEditingController amountRecived = TextEditingController();
  final TextEditingController remainingAmound = TextEditingController();
  final TextEditingController note = TextEditingController();
  final FocusNode s = FocusNode();
  final FocusNode ss = FocusNode();
  final FocusNode sss = FocusNode();
  final FocusNode ssss = FocusNode();
  final FocusNode sssss = FocusNode();
  final FocusNode ssssss = FocusNode();
  final FocusNode _sssssss = FocusNode();
  final TextEditingController currencyControler = TextEditingController();
  final FocusNode currencyFoucs = FocusNode();
  GlobalKey<FormState> globalKey = GlobalKey();
  List<AccountModel> searchResults = [];
  bool isSearching = false;
  int accIdd = 0;
  List<BillDetailsModel> bills = [];
  BillModel billData = BillModel(
    bilId: 0,
    accId: 0,
    bilNumber: 'bilNumber',
    bilTotal: 0,
    bilDiscount: 0,
    bilExtra: 0,
    bilDate: DateTime.now(),
    bilKind: '',
    bilNet: 0,
    bilNote: '',
    bilPayment: 0,
    payType: 1,
    curId: 0,
  );
  late String billType;
  late bool isNew;

  @override
  void initState() {
    super.initState();
    discount.addListener(calculateTotals);
    amountRecived.addListener(calculateTotals);
  }

  @override
  void dispose() {
    discount.removeListener(calculateTotals);
    amountRecived.removeListener(calculateTotals);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    discount.text = '0';
    amountRecived.text = '0';

    final Map<String, dynamic> billList =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (billList['cur_id'] == 1) {
      currencyControler.text = 'ليرة سورية';
    } else {
      currencyControler.text = 'دولار';
    }
    bills = billList['bill'];
    countInvois.text = billList['total'];
    billType = billList['billType'];
    isNew = billList['isNew'];
    if (!isNew) {
      billData = billList['billModel'];
    }

    if (!isNew) {
      billType = billData.bilKind.toString();
      final accounts = context.read<AccountsCubit>().accounts;
      final account = accounts.firstWhere(
        (acc) => acc.accID == billData.accId,
        orElse:
            () => AccountModel(
              accName: '',
              accKind: 0,
              accNumber: 0,
              accRefrence: 0,
              parentId: 0,
            ),
      );
      nameAccount.text = account.accName;
      discount.text = billData.bilDiscount.toString();
      amountRecived.text = billData.bilPayment.toString();
      totalInvois.text = billData.bilTotal.toString();
      remainingAmound.text = billData.bilNet.toString();
      date.text = billData.bilDate.toString().split(' ')[0];
      hour.text = billData.bilDate.toString().split(' ')[1].substring(0, 5);
      note.text = billData.bilNote ?? '';
    }
    calculateTotals();
  }

  void calculateTotals() {
    final total = double.tryParse(countInvois.text) ?? 0;
    final discountValue = double.tryParse(discount.text) ?? 0;
    final paid = double.tryParse(amountRecived.text) ?? 0;
    final net = total - discountValue;
    final remaining = net - paid;
    totalInvois.text = net.toStringAsFixed(1);
    remainingAmound.text = remaining.toStringAsFixed(1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: isNew ? 'فاتورة مبيعات جديدة' : 'تعديل فاتورة',
        showIcons: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Form(
              key: globalKey,
              child: Column(
                children: [
                  ContainerFields(
                    children: [
                      TextFieldAndDetails(
                        validator: (p0) {
                          if (p0 == ' ' || p0 == null || p0 == '') {
                            return 'ادخل اسم الحساب';
                          }
                          return null;
                        },
                        focusNode: s,
                        controller: nameAccount,
                        icon: IconButton(
                          onPressed: () {
                            nameAccount.clear();
                          },
                          icon: Icon(Icons.close, color: kBlack),
                        ),
                        hintText: 'اسم الحساب',
                        onChangedl: searchAccount,
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
                                      nameAccount.text = account.accName;
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomTextField(
                          validator: (p0) {
                            if (p0 == null || p0 == '') {
                              return 'الرجاء ادخال العملة';
                            }
                            return null;
                          },
                          canRead: true,
                          suffixIcon: InkWell(
                            onTapDown: (TapDownDetails details) {
                              final RenderBox overlay =
                                  Overlay.of(context).context.findRenderObject()
                                      as RenderBox;
                              showMenu(
                                context: context,
                                position: RelativeRect.fromRect(
                                  details.globalPosition & const Size(60, 60),
                                  Offset.zero & overlay.size,
                                ),
                                items: [
                                  PopupMenuItem(
                                    child: Text('ليرة سورية'),
                                    onTap:
                                        () =>
                                            currencyControler.text =
                                                'ليرة سورية',
                                  ),
                                  PopupMenuItem(
                                    child: Text('دولار'),
                                    onTap:
                                        () => currencyControler.text = 'دولار',
                                  ),
                                ],
                              );
                            },
                            child: Icon(Icons.arrow_drop_down, size: 33),
                          ),
                          hintText: 'العملة',
                          controller: currencyControler,
                          focusNode: currencyFoucs,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.sizeOf(context).width * 0.77,
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: const Padding(
                                padding: EdgeInsets.all(1),
                                child: RadioMenuButtons(),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                'نمط الدفع',
                                style: FontStyleApp.blueAccent18.copyWith(
                                  fontSize: getResponsiveText(context, 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextFieldAndDetails(
                        focusNode: FocusNode(),
                        hintText: 'الصندوق الرئيسي',
                        controller: mainBox,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ContainerFields(
                    children: [
                      TextFieldAndDetails(
                        focusNode: ss,
                        keyType: TextInputType.number,
                        canRead: true,
                        hintText: 'مجموع الفاتورة',
                        controller: countInvois,
                      ),
                      TextFieldAndDetails(
                        focusNode: ssssss,
                        keyType: TextInputType.number,
                        hintText: 'الحسم الممنوح',
                        controller: discount,
                      ),
                      TextFieldAndDetails(
                        focusNode: sss,
                        keyType: TextInputType.number,
                        hintText: 'صافي الفاتورة',
                        controller: totalInvois,
                        canRead: true,
                      ),
                      TextFieldAndDetails(
                        canRead: RadioMenuButtons.payType == 0 ? true : false,
                        focusNode: ssss,
                        keyType: TextInputType.number,
                        hintText: 'المبلغ المقبوض',
                        controller: amountRecived,
                      ),
                      TextFieldAndDetails(
                        focusNode: sssss,
                        keyType: TextInputType.number,
                        hintText: 'المبلغ المتبقي',
                        controller:
                            RadioMenuButtons.payType == 0
                                ? TextEditingController(text: '0')
                                : remainingAmound,
                        canRead: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ContainerFields(
                    children: [
                      TextFieldDate(
                        date: date,
                        hoursOrYear: true,
                        label: 'التاريخ',
                      ),
                      TextFieldDate(
                        date: hour,
                        hoursOrYear: false,
                        label: 'الوقت',
                      ),
                      CommentsTextField(
                        width: MediaQuery.sizeOf(context).width * 0.75,
                        focusNode: _sssssss,
                        maxLines: 4,
                        label: 'ملاحظة',
                        controller: note,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomContainer(
                    borderRadius: BorderRadius.circular(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('طباعة الفاتور أيضاً'),
                        Checkbox(value: false, onChanged: (value) {}),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocConsumer<BillCubit, BillStatus>(
                    listener: (context, state) {
                      if (state is SuccessStateBill) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          HomeView.id,
                          (route) => false,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          customSnackBar(
                            context,
                            isNew
                                ? 'تم اضافة الفاتورة بنجاح'
                                : 'تم تعديل الفاتورة بنجاح',
                            kBlueAccent,
                          ),
                        );
                      } else if (state is FaliureStateBill) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          HomeView.id,
                          (route) => false,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          customSnackBar(
                            context,
                            'حدث خطأ اثناء العملية',
                            kRed,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadingStateBill) {
                        return Center(
                          child: CircularProgressIndicator(color: kBlueAccent),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButtonSave(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                label: 'الغاء',
                              ),
                              CustomButtonSave(
                                onTap: insertOrUpdateBill,
                                label: 'حفظ',
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
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
        accounts
            .where(
              (account) =>
                  account.accName.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    setState(() {
      searchResults = results;
    });
  }

  String generateRandomBillNumber() {
    final random = Random();
    String number = '';
    for (int i = 0; i < 6; i++) {
      number += random.nextInt(10).toString(); // رقم من 0 إلى 9
    }
    return number;
  }

  void insertOrUpdateBill() async {
    if (globalKey.currentState!.validate()) {
      try {
        accIdd = 0;
        for (var element in context.read<AccountsCubit>().accounts) {
          if (element.accName == nameAccount.text) {
            accIdd = element.accID!;
            break;
          }
        }

        if (accIdd == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(context, 'لم يتم العثور على الحساب', kRed),
          );
          return;
        }

        String timeString = hour.text.trim().toUpperCase();
        final amPmRegex = RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)');
        int hourNum = 0;
        int minuteNum = 0;

        if (amPmRegex.hasMatch(timeString)) {
          final match = amPmRegex.firstMatch(timeString)!;
          hourNum = int.parse(match.group(1)!);
          minuteNum = int.parse(match.group(2)!);
          String amPm = match.group(3)!;

          if (amPm == "PM" && hourNum != 12) {
            hourNum += 12;
          } else if (amPm == "AM" && hourNum == 12) {
            hourNum = 0;
          }
        } else {
          final parts = timeString.split(':');
          hourNum = int.parse(parts[0]);
          minuteNum = int.parse(parts[1]);
        }
        final dateParts = date.text.split('-');
        if (dateParts.length != 3) {
          throw FormatException('تنسيق التاريخ غير صحيح');
        }
        int year = int.parse(dateParts[0]);
        int month = int.parse(dateParts[1]);
        int day = int.parse(dateParts[2]);

        DateTime billDate = DateTime(year, month, day, hourNum, minuteNum);

        final BillModel bill = BillModel(
          payType: RadioMenuButtons.payType,
          bilId: isNew ? 0 : billData.bilId,
          accId: accIdd,
          bilNumber: isNew ? generateRandomBillNumber() : billData.bilNumber,
          bilTotal: double.tryParse(totalInvois.text) ?? 0,
          bilDiscount: double.tryParse(discount.text) ?? 0,
          bilExtra: 0,
          bilKind: billType,
          bilPayment: double.tryParse(amountRecived.text) ?? 0,
          bilNet: double.tryParse(remainingAmound.text) ?? 0,
          bilDate: billDate,
          bilNote: note.text,
          curId: currencyControler.text == 'دولار' ? 1 : 0,
        );

        if (isNew) {
          await context.read<BillCubit>().insertBill(bill, bills);
        } else {
          await context.read<BillCubit>().updateBill(bill, bills);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(context, 'حدث خطأ: ${e.toString()}', kRed),
        );
      }
    }
  }
}
