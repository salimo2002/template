import 'package:flutter/material.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/invoice%20details%20view/text_field_date.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';

class FundJournalView extends StatefulWidget {
  const FundJournalView({super.key});
  static String id = 'FundJournalView';

  @override
  State<FundJournalView> createState() => _FundJournalViewState();
}

class _FundJournalViewState extends State<FundJournalView> {
  TextEditingController firstDateController = TextEditingController();
  TextEditingController lastDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'يومية الصندوق',
        showIcons: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: ContainerFields(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              child: TextFieldDate(
                                canRead: false,
                                date: lastDateController,
                                hoursOrYear: true,
                                label: 'الى تاريخ',
                              ),
                            ),
                            SizedBox(height: 15),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              child: TextFieldDate(
                                canRead: false,
                                date: firstDateController,
                                hoursOrYear: true,
                                label: 'من تاريخ',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,

                  child: ContainerFields(
                    children: [
                      RowInFundJournalView(lable: ':نوع السند', value: 'قبض'),
                      RowInFundJournalView(lable: ':المبلغ', value: '5000'),
                      RowInFundJournalView(
                        lable: ':الحساب المقابل',
                        value: 'جسومي',
                      ),
                      RowInFundJournalView(lable: ':العملة', value: 'دولارو'),
                      RowInFundJournalView(
                        lable: ':البيان',
                        value: 'زوبي اند زوبي',
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
}

class RowInFundJournalView extends StatelessWidget {
  const RowInFundJournalView({
    super.key,
    required this.lable,
    required this.value,
  });
  final String lable;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: FontStyleApp.black18.copyWith(
            fontSize: getResponsiveText(context, 15),
          ),
        ),
        SizedBox(width: 5),
        Text(
          lable,
          style: FontStyleApp.blueAccent18.copyWith(
            fontSize: getResponsiveText(context, 15),
          ),
        ),
      ],
    );
  }
}
