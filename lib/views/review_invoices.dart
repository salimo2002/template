import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/invoice%20details%20view/radio_menu_buttons.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class ReviewInvoices extends StatefulWidget {
  const ReviewInvoices({super.key});

  static String id = 'ReviewInvoices';

  @override
  State<ReviewInvoices> createState() => _ReviewInvoicesState();
}

class _ReviewInvoicesState extends State<ReviewInvoices> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'استعراض فواتير',
        showIcons: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            CustomContainer(
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 10,
                  children: [
                    CustomTextField(
                      hintText: 'فواتير المبيعات',
                      controller: TextEditingController(),
                      focusNode: _focusNode,
                    ),
                    CustomTextField(
                      hintText: 'الحساب المتربط',
                      controller: TextEditingController(),
                      focusNode: _focusNode2,
                    ),
                  ],
                ),
              ),
            ),
            CustomContainer(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                spacing: 10,
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
            ),
          ],
        ),
      ),
    );
  }
}
