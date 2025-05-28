import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_status.dart';
import 'package:template/models/bill_details_model.dart';
import 'package:template/models/bill_model.dart';
import 'package:template/utils/bill_type.dart';
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
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
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
  final TextEditingController numberBebar = TextEditingController();
  final TextEditingController note = TextEditingController();
  final FocusNode s = FocusNode();
  final FocusNode ss = FocusNode();
  final FocusNode sss = FocusNode();
  final FocusNode ssss = FocusNode();
  final FocusNode sssss = FocusNode();
  final FocusNode ssssss = FocusNode();
  int accIdd = 0;
  List<BillDetailsModel> bills = [];
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
    Map<String, dynamic> billList =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    bills = billList['bill'];
    countInvois.text = billList['total'];

    calculateTotals();
    super.didChangeDependencies();
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
        title: 'فاتورة مبيعات جديدة',
        showIcons: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                ContainerFields(
                  children: [
                    TextFieldAndDetails(
                      focusNode: s,
                      controller: nameAccount,
                      icon: const Icon(Icons.close),
                      hintText: 'اسم الحساب',
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kWhite,
                      ),
                      height: 30,
                      width: MediaQuery.sizeOf(context).width * 0.77,
                      child: Center(
                        child: Text(
                          'الرصيد: 2500',
                          style: FontStyleApp.black18.copyWith(
                            fontSize: getResponsiveText(context, 14),
                          ),
                        ),
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
                      focusNode: ssss,
                      keyType: TextInputType.number,
                      hintText: 'المبلغ المقبوض',
                      controller: amountRecived,
                    ),

                    TextFieldAndDetails(
                      focusNode: sssss,
                      keyType: TextInputType.number,
                      hintText: 'المبلغ المتبقي',
                      controller: remainingAmound,
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
                    TextFieldAndDetails(
                      focusNode: FocusNode(),
                      keyType: TextInputType.number,
                      hintText: 'رقم الورقة',
                      controller: numberBebar,
                    ),
                    CommentsTextField(
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
                          'تم اضافة الفاتورة بنجاح',
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
                          'حدث خطأ اثناء اضافة الفاتورة',
                          kBlueAccent,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is SuccessStateBill) {
                      return TextButton(
                        onPressed: insertBill,
                        child: Text(
                          'حفظ وإنهاء',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 130, 128, 128),
                            fontSize: getResponsiveText(context, 20),
                          ),
                        ),
                      );
                    } else if (state is LoadingStateBill) {
                      return Center(
                        child: CircularProgressIndicator(color: kBlueAccent),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void insertBill() {
    for (var element in AccountsCubit.accounts) {
      if (element.accName == nameAccount.text) {
        accIdd = element.accID!;
      }
    }
    context.read<BillCubit>().insertBill(
      BillModel(
        bilId: null,
        accId: accIdd,
        bilNumber: '10',
        bilTotal: double.parse(totalInvois.text),
        bilDiscount: double.parse(discount.text),
        bilExtra: double.parse('1'),
        bilKind: BillType.sales,
        bilPayment: double.parse(amountRecived.text),
        bilNet: double.parse(remainingAmound.text),
      ),
      bills,
    );
  }
}
