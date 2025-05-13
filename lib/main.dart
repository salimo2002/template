import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/account%20service/accounts_cubit.dart';
import 'package:template/category%20cubit/category_cubit.dart';
import 'package:template/material%20cubit/material_cubit.dart';
import 'package:template/utils/constants.dart';
import 'package:template/views/add_account_and_update_view.dart';
import 'package:template/views/create_a_sales_Invoice.dart';
import 'package:template/views/home_view.dart';
import 'package:template/views/material_card_view.dart';
import 'package:template/views/material_classifications_view.dart';
import 'package:template/views/new_material_view.dart';
import 'package:template/views/edit_prodict_view.dart';
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
        BlocProvider<MaterialCubit>(
          create: (context) {
            return MaterialCubit();
          },
        ),
        BlocProvider<CategoryCubit>(
          create: (context) {
            return CategoryCubit();
          },
        ),
        BlocProvider<AccountsCubit>(
          create: (context) {
            return AccountsCubit();
          },
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
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
          CreateASalesInvoice.id: (context) => CreateASalesInvoice(),
        },
        initialRoute: HomeView.id,
      ),
    );
  }
}
