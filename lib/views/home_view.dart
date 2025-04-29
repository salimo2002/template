import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/material%20cubit/material_cubit.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/Service/material_services.dart';
import 'package:template/widgets/home%20view%20widgets/accounts.dart';
import 'package:template/widgets/home%20view%20widgets/create_financial_documents.dart';
import 'package:template/widgets/home%20view%20widgets/debts_and_supplies.dart';
import 'package:template/widgets/home%20view%20widgets/financial_reports.dart';
import 'package:template/widgets/home%20view%20widgets/lookup.dart';
import 'package:template/widgets/home%20view%20widgets/product_catalog.dart';
import 'package:template/widgets/home%20view%20widgets/store_section.dart';
import 'package:template/widgets/home%20view%20widgets/view_invoices.dart';
import 'package:template/widgets/home%20view%20widgets/parts_titel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static String id = 'HomeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<MaterialCubit>().fetchMaterials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          'تداول',
          style: FontStyleApp.white18.copyWith(
            fontSize: getResponsiveText(context, 18),
          ),
        ),
        backgroundColor: kBlueAccent,
        actions: [
          IconButton(
            onPressed: () async {
              MaterialServices.fetchMaterials();
            },
            icon: Icon(Icons.more_vert_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              spacing: 5,
              children: [
                PartsTitle(title: 'نسخة تجريبية محدودة', color: kRed),
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
      ),
    );
  }
}
