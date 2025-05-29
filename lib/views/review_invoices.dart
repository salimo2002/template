import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/invoice_review_view.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 15,
                    children: [
                      ContainerFields(
                        children: [
                          CustomTextField(
                            canRead: true,
                            suffixIcon: IconButton(
                              color: kBlueAccent,
                              onPressed: () {},
                              icon: InkWell(
                                onTapDown: showUnits,
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: kBlueAccent,
                                  size: 30,
                                ),
                              ),
                            ),
                            hintText: 'فواتير المبيعات',
                            controller: TextEditingController(),
                            focusNode: _focusNode,
                          ),
                          CustomTextField(
                            suffixIcon: InkWell(
                              onTapDown: (details) {},

                              child: Icon(
                                Icons.more_vert,
                                color: kBlueAccent,
                                size: 25,
                              ),
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
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, top: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, InvoiceReviewView.id);
                  },
                  child: Text(
                    'موافق',
                    style: FontStyleApp.black18.copyWith(
                      fontSize: getResponsiveText(context, 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showUnits(TapDownDetails details) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      menuPadding: EdgeInsets.zero,
      context: context,
      position: RelativeRect.fromRect(
        details.globalPosition & const Size(60, 60),
        Offset.zero & overlay.size,
      ),
      items: [
        CheckedPopupMenuItem(
          child: Center(child: Text('فواتير المشتريات')),
          onTap: () {},
        ),
        CheckedPopupMenuItem(
          child: Center(child: Text('فواتير المبيعات')),
          onTap: () {},
        ),
        CheckedPopupMenuItem(
          child: Center(child: Text('فواتير مرتجع المشتريات')),
          onTap: () {},
        ),
        CheckedPopupMenuItem(
          child: Center(child: Text('فواتير مرتجع المبيعات')),
          onTap: () {},
        ),
      ],
    );
  }
}
