import 'package:flutter/material.dart';
import 'package:template/utils/bill_type.dart';
import 'package:template/views/create_a_sales_invoice_view.dart';
import 'package:template/views/review_invoices.dart';
import 'package:template/widgets/home%20view%20widgets/custom_button_.dart';

class CreateFinancialDocuments extends StatelessWidget {
  const CreateFinancialDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FittedBox(
            child: Row(
              spacing: 50,
              children: [
                CustomButton(
                  text: 'فاتورة مردود مشتريات',
                  icon: 'assets/img/home cards/medical-icon_i-billing.svg',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CreateASalesInvoiceView.id,
                      arguments: BillType.undoBuy,
                    );
                  },
                ),
                CustomButton(
                  text: 'فاتورة مبيعات',
                  icon: 'assets/img/home cards/hugeicons_payment-01.svg',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CreateASalesInvoiceView.id,
                      arguments: BillType.sales,
                    );
                  },
                ),
                CustomButton(
                  text: 'فاتورة مشتريات',
                  icon: 'assets/img/home cards/hugeicons_payment-02.svg',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CreateASalesInvoiceView.id,
                      arguments: BillType.buy,
                    );
                  },
                ),
              ],
            ),
          ),
          Row(
            spacing: 50,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                text: 'فاتورة طلبات',
                icon: 'assets/img/home cards/fluent-mdl2_product-variant.svg',
                onTap: () {},
              ),
              CustomButton(
                text: 'فاتورة مردود مبيعات',
                icon: 'assets/img/home cards/marketeq_bill-dollar.svg',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    CreateASalesInvoiceView.id,
                    arguments: BillType.undoSell,
                  );
                },
              ),
            ],
          ),
          Divider(),
          CustomButton(
            text: 'استعراض الفواتير',
            icon: 'assets/img/home cards/hugeicons_payment-01.svg',
            onTap: () {
              Navigator.pushNamed(context, ReviewInvoices.id);
            },
          ),
        ],
      ),
    );
  }
}
