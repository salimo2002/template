import 'package:flutter/material.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/Invoice%20review/filter_invoice_review.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';

class InvoiceReviewView extends StatelessWidget {
  const InvoiceReviewView({super.key});
  static String id = 'InvoiceReviewView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'فواتير مشتريات',
        showIcons: false,
      ),
      body: Column(
        children: [
          FilterInvoiceReview(),
          SizedBox(height: 20),
          ContainerFields(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'نقداً',
                    style: FontStyleApp.blueAccent18.copyWith(
                      fontSize: getResponsiveText(context, 14),
                    ),
                  ),
                  Text(
                    'فاتورة مشتريات رقم : 1',
                    style: FontStyleApp.blueAccent18.copyWith(
                      fontSize: getResponsiveText(context, 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
