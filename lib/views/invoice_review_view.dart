import 'package:flutter/material.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/widgets/Invoice%20review/filter_invoice_review.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [FilterInvoiceReview()]),
      ),
    );
  }
}
