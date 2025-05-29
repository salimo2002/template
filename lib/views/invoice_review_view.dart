import 'package:flutter/material.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/Invoice%20review/filter_invoice_review.dart';
import 'package:template/widgets/item%20card%20view%20widgets/table_fields.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15),
          FilterInvoiceReview(),
          SizedBox(height: 40),
          ContainerFields(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '25-5-2025',
                    style: FontStyleApp.grey14.copyWith(
                      fontSize: getResponsiveText(context, 14),
                    ),
                  ),
                  Text(
                    '4:00 PM',
                    style: FontStyleApp.grey14.copyWith(
                      fontSize: getResponsiveText(context, 14),
                    ),
                  ),
                  Text(
                    'مورد نقدي',
                    style: FontStyleApp.grey14.copyWith(
                      fontSize: getResponsiveText(context, 14),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'المستودع الرئيسي',
                    style: FontStyleApp.blackCustom18.copyWith(
                      fontSize: getResponsiveText(context, 16),
                    ),
                  ),
                ],
              ),
              TableFIelds(
                lable1: 'المبلغ المتبقي',
                value1: '500',
                lable2: 'المبلغ المدفوع',
                value2: '250',
                lable3: 'مبلغ الفاتورة',
                value3: '500',
              ),SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'هنا يوجد نص',
                    style: FontStyleApp.blackCustom18.copyWith(
                      fontSize: getResponsiveText(context, 16),
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
