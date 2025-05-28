import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/Invoice%20review/filter_invoice_review.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/invoice%20details%20view/radio_menu_buttons.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
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
  final TextEditingController invoiceController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'استعراض فواتير',
        showIcons: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 15,
          children: [
            ContainerFields(
              children: [
                CustomTextField(
                  suffixIcon: IconButton(
                    color: kBlueAccent,
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: kBlueAccent,
                      size: 30,
                    ),
                  ),
                  hintText: 'فواتير المبيعات',
                  controller: TextEditingController(),
                  focusNode: _focusNode,
                ),
                CustomTextField(
                  suffixIcon: IconButton(
                    color: kBlueAccent,
                    onPressed: () {},
                    icon: Icon(Icons.more_vert, color: kBlueAccent, size: 25),
                  ),
                  hintText: 'الحساب المتربط',
                  controller: TextEditingController(),
                  focusNode: _focusNode2,
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
            FilterInvoiceReview(),
          ],
        ),
      ),
    );
  }
}
