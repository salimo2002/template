import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/widgets/home%20view%20widgets/accounts.dart';
import 'package:template/widgets/home%20view%20widgets/create_financial_documents.dart';
import 'package:template/widgets/home%20view%20widgets/debts_and_supplies.dart';
import 'package:template/widgets/home%20view%20widgets/financial_reports.dart';
import 'package:template/widgets/home%20view%20widgets/lookup.dart';
import 'package:template/widgets/home%20view%20widgets/product_catalog.dart';
import 'package:template/widgets/home%20view%20widgets/store_section.dart';
import 'package:template/widgets/home%20view%20widgets/view_invoices.dart';
import 'package:template/widgets/parts_titel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = 'HomeView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('تداول', style: FontStyleApp.white18),
        backgroundColor: kblueAccent,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            spacing: 5,
            children: [
              PartsTitle(title: 'نسخة تجريبية محدودة', color: kred),
              StoreSection(),
              CreateFinancialDocuments(),
              ViewInvoices(),
               ProductCatalog(),
               Lookup(),
                Accounts(),
               DebtsAndSupplies(),
              FinancialReports(),
            ],
          ),
        ),
      ),
    );
  }
}
