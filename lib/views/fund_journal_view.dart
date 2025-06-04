import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/Invoice%20review/filter_invoice_review.dart';
import 'package:template/widgets/invoice%20details%20view/comments_text_field.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_save.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class FundJournalView extends StatefulWidget {
  const FundJournalView({super.key});
  static String id = 'FundJournalView';

  @override
  State<FundJournalView> createState() => _FundJournalViewState();
}

class _FundJournalViewState extends State<FundJournalView> {
  TextEditingController receivablesControler = TextEditingController();
  TextEditingController paymentsControler = TextEditingController();
  TextEditingController accountControler = TextEditingController();
  TextEditingController currencyControler = TextEditingController();
  TextEditingController statementControler = TextEditingController();
  FocusNode receivablesFoucs = FocusNode();
  FocusNode paymentsFoucs = FocusNode();
  FocusNode accountFoucs = FocusNode();
  FocusNode currencyFoucs = FocusNode();
  FocusNode statementFoucs = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'يومية الصندوق',
        showIcons: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ContainerFields(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ContainerFilter(
                        height: 35,
                        width: MediaQuery.sizeOf(context).width * .22,
                        text: 'تاريخ مخصص',
                        containerColor: kWhite,
                        textColor: kBlueAccent,
                      ),
                      ContainerFilter(
                        height: 35,
                        width: MediaQuery.sizeOf(context).width * .22,
                        text: 'الشهر',
                        containerColor: kWhite,
                        textColor: kBlueAccent,
                      ),
                      ContainerFilter(
                        height: 35,
                        width: MediaQuery.sizeOf(context).width * .22,
                        text: 'اليوم',
                        containerColor: kBlueAccent,
                        textColor: kWhite,
                      ),
                      Flexible(
                        child: Text(
                          ' : حركة ',
                          style: FontStyleApp.blackCustom18.copyWith(
                            fontSize: getResponsiveText(context, 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            ContainerFields(
              children: [
                CustomTextField(
                  keyType: TextInputType.number,
                  hintText: 'المقبوضات',
                  controller: receivablesControler,
                  focusNode: receivablesFoucs,
                ),
                CustomTextField(
                  keyType: TextInputType.number,
                  hintText: 'المدفوعات',
                  controller: paymentsControler,
                  focusNode: paymentsFoucs,
                ),
                CustomTextField(
                  hintText: 'الحساب المقابل',
                  controller: accountControler,
                  focusNode: accountFoucs,
                ),
                CustomTextField(
                  canRead: false,
                  suffixIcon: InkWell(
                    onTapDown: (details) {},
                    child: Icon(Icons.arrow_drop_down, size: 33),
                  ),
                  hintText: 'العملة',
                  controller: currencyControler,
                  focusNode: currencyFoucs,
                ),
                CommentsTextField(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  maxLines: 4,
                  label: 'البيان',
                  controller: statementControler,
                  focusNode: statementFoucs,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height*.28),
            Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [CustomButtonSave(onTap: () {}, label: 'الغاء'),
              CustomButtonSave(onTap: () {}, label: 'حفظ'),],)
          ],
        ),
      ),
    );
  }
}
