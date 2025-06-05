import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/category%20cubit/category_cubit.dart';
import 'package:template/cubit/company%20cubit/company_cubit.dart';
import 'package:template/cubit/debit%20cubit/debit_cubit.dart';
import 'package:template/cubit/material%20cubit/material_cubit.dart';
import 'package:template/utils/constants.dart';
import 'package:template/views/account_statement_view.dart';
import 'package:template/views/add_account_and_update_view.dart';
import 'package:template/views/create_a_sales_invoice_view.dart';
import 'package:template/views/fund_journal_view.dart';
import 'package:template/views/home_view.dart';
import 'package:template/views/invoice_details_view.dart';
import 'package:template/views/invoice_review_view.dart';
import 'package:template/views/log_in_view.dart';
import 'package:template/views/material_card_view.dart';
import 'package:template/views/material_classifications_view.dart';
import 'package:template/views/new_material_view.dart';
import 'package:template/views/edit_prodict_view.dart';
import 'package:template/views/review_invoices.dart';
import 'package:template/views/setting_view.dart';
import 'package:template/views/splash_view.dart';
import 'package:template/views/detailed_account_statement_views.dart';
import 'package:template/views/support_details_views.dart';
import 'package:template/views/support_views.dart';
import 'package:template/views/tree_accounts_view.dart';

void main(List<String> args) {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: kWhite,
      systemNavigationBarColor: kWhite,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(Template());
}

class Template extends StatelessWidget {
  const Template({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MaterialCubit>(create: (context) => MaterialCubit()),
        BlocProvider<CategoryCubit>(create: (context) => CategoryCubit()),
        BlocProvider<AccountsCubit>(create: (context) => AccountsCubit()),
        BlocProvider<BillCubit>(create: (context) => BillCubit()),
        BlocProvider<DebitCubit>(create: (context) => DebitCubit()),
        BlocProvider(create: (context) => CompanyCubit()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kBackGroundColor,
          radioTheme: RadioThemeData(
            fillColor: WidgetStateProperty.all(kBlueAccent),
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(iconColor: WidgetStateProperty.all(kWhite)),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: kBlueAccent),
        ),
        routes: {
          HomeView.id: (context) => const HomeView(),
          MaterialCardView.id: (context) => const MaterialCardView(),
          NewMaterialView.id: (context) => const NewMaterialView(),
          MaterialClassificationsView.id:
              (context) => const MaterialClassificationsView(),
          EditProdictView.id: (context) => EditProdictView(),
          TreeAccountsView.id: (context) => TreeAccountsView(),
          AddAccountAndUpdateView.id: (context) => AddAccountAndUpdateView(),
          CreateASalesInvoiceView.id: (context) => CreateASalesInvoiceView(),
          InvoiceDetailsView.id: (context) => InvoiceDetailsView(),
          SplashVideoScreen.id: (context) => SplashVideoScreen(),
          InvoiceReviewView.id: (context) => InvoiceReviewView(),
          ReviewInvoices.id: (context) => ReviewInvoices(),
          SettingView.id: (context) => SettingView(),
          SupportViews.id: (context) => SupportViews(),
          AccountStatementView.id: (context) => AccountStatementView(),
          LogInView.id: (context) => LogInView(),
          AccountStatementView.id: (context) => AccountStatementView(),
          SupportDetailsViews.id: (context) => SupportDetailsViews(),
          DetailedAccountStatementView.id:
              (context) => DetailedAccountStatementView(),
          FundJournalView.id: (context) => FundJournalView(),
        },
        initialRoute: LogInView.id,
      ),
    );
  }
}
