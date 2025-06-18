import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/Service/bill_service.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/company%20cubit/company_cubit.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/home%20view%20widgets/accounts.dart';
import 'package:template/widgets/home%20view%20widgets/create_financial_documents.dart';
import 'package:template/widgets/home%20view%20widgets/custom_drawer.dart';
import 'package:template/widgets/home%20view%20widgets/financial_reports.dart';
import 'package:template/widgets/home%20view%20widgets/product_catalog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static String id = 'HomeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 3;
  final List<Widget> _pages = [
    SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(children: [CreateFinancialDocuments()]),
    ),
    SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: FinancialReports(),
    ),
    SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: SizedBox(height: 700, child: AccountsAndMaterialsTab()),
    ),
    SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(children: [ProductCatalog()]),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          context.read<CompanyCubit>().comp.comName,
          style: FontStyleApp.white18.copyWith(
            fontSize: getResponsiveText(context, 18),
          ),
        ),
        backgroundColor: kBlueAccent,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                // context.read<BillCubit>().fetchMovementBills(
                //   databaseName: 'itechsy_test',
                //   dateFrom: '2025-01-01',
                //   dateTo: '2025-06-18',
                //   matId: '1248',
                // );
                // List data = await BillServices.fetchMovementBills(
                //   databaseName: 'itechsy_test',
                //   dateFrom: '2025-01-01',
                //   dateTo: '2025-06-18',
                //   matId: '1248',
                // );
                // log(data.toString());
              } catch (e) {
                log('حدث خطأ: $e');
              }
            },
            icon: Icon(Icons.more_vert_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(child: _pages[_currentIndex]),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0, left: 5, right: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [bosShadow()],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BottomNavigationBar(
                      currentIndex: _currentIndex,
                      onTap: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.white,
                      selectedItemColor: kBlueAccent,
                      unselectedItemColor: Colors.black,
                      selectedLabelStyle: FontStyleApp.white18.copyWith(
                        fontSize: getResponsiveText(context, 12),
                      ),
                      unselectedLabelStyle: FontStyleApp.white18.copyWith(
                        fontSize: getResponsiveText(context, 12),
                      ),
                      elevation: 0,
                      items: [
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            'assets/img/Home/lets-icons_paper-light.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              _currentIndex == 0 ? kBlueAccent : kBlack,
                              BlendMode.srcIn,
                            ),
                          ),
                          label: "فواتير",
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            'assets/img/Home/carbon_report-data.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              _currentIndex == 1 ? kBlueAccent : kBlack,
                              BlendMode.srcIn,
                            ),
                          ),
                          label: "المواد",
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            'assets/img/Home/si_inventory-line.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              _currentIndex == 2 ? kBlueAccent : kBlack,
                              BlendMode.srcIn,
                            ),
                          ),
                          label: "الحسابات",
                        ),
                        BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            'assets/img/Home/mynaui_home.svg',
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              _currentIndex == 3 ? kBlueAccent : kBlack,
                              BlendMode.srcIn,
                            ),
                          ),
                          label: "الرئيسية",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountsAndMaterialsTab extends StatefulWidget {
  const AccountsAndMaterialsTab({super.key});

  @override
  State<AccountsAndMaterialsTab> createState() =>
      _AccountsAndMaterialsTabState();
}

class _AccountsAndMaterialsTabState extends State<AccountsAndMaterialsTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [SizedBox(height: 10), Accounts()],
    );
  }
}
