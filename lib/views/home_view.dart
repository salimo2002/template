import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/cubit/company%20cubit/company_cubit.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/device_type.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/home%20view%20widgets/accounts.dart';
import 'package:template/widgets/home%20view%20widgets/create_financial_documents.dart';
import 'package:template/widgets/home%20view%20widgets/custom_drawer.dart';
import 'package:template/widgets/home%20view%20widgets/debts_and_supplies.dart';
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
    log('ssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
    log(
      'Name: ${context.read<CompanyCubit>().comp.comName} Id: ${context.read<CompanyCubit>().comp.comId} Serial: ${context.read<CompanyCubit>().comp.comSerial} Count: ${context.read<CompanyCubit>().comp.comCount}',
    );
    return Scaffold(
      drawer: CustomDrawer(),
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
              //  var s = await DeviceType.getDeviceImei();
              // log(s ?? 'non');
              // final DebitModel debit = DebitModel(
              //   debId: 0,
              //   voucherNumber: 1002,
              //   accId: 1,
              //   accId2: 491,
              //   debAmount: 525.25,
              //   ty: 0,
              //   debNote: 'debNote',
              //   curId: 1,
              //   debDate: DateTime.now(),
              // );
              // context.read<DebitCubit>().insertDebit(debit);

              // {
              //   "voucher_number":1001,
              //   "acc_id": 1,
              //   "acc_id2": 491,
              //   "deb_amount": 500.75,
              //   "ty": 2,
              //   "deb_note": "دفعة جديدة",
              //   "cur_id": 1,
              //   "deb_date": "2025-06-04",
              // };
            },

            //   final details = [
            //     {
            //       "acc_id": 491,
            //       "acc_id2": 456,
            //       "det_maduin": 200,
            //       "det_loaner": 300,
            //       "cur_id": 1,
            //     },
            //     {
            //       "acc_id": 456,
            //       "acc_id2": 491,
            //       "det_maduin": 400,
            //       "det_loaner": 500,
            //       "cur_id": 2,
            //     },
            //   ];

            //   // إرسال البيانات إلى API
            //   await DebitService.addDebitWithDetails(
            //     debit: debit,
            //     details: details,
            //   );

            //   try {
            //     await DebitService.addDebitWithDetails(
            //       debit: debit,
            //       details: details,
            //     );
            //   } on Exception catch (e) {
            //     throw Exception(e);
            //   }
            // },
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
                          label: "تقارير",
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
                          label: "الحسابات والمواد",
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
    return Column(
      children: [
        const SizedBox(height: 8),
        TabBar(
          dividerColor: Colors.transparent,
          controller: _tabController,
          labelColor: kBlueAccent,
          unselectedLabelColor: kBlack,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 2.5, color: kBlueAccent),
            insets: EdgeInsets.symmetric(horizontal: 1),
          ),
          tabs: const [Tab(text: 'المواد'), Tab(text: 'الحسابات')],
        ),
        SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [DebtsAndSupplies(), Accounts()],
          ),
        ),
      ],
    );
  }
}
