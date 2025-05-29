import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/home%20view%20widgets/accounts.dart';
import 'package:template/widgets/home%20view%20widgets/create_financial_documents.dart';
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
  int _currentIndex = 0;

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
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined)),
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
                          label: "حسابات وموارد",
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
          tabs: const [Tab(text: 'دليل الحسابات'), Tab(text: 'دليل المواد')],
        ),
        SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [Accounts(), DebtsAndSupplies()],
          ),
        ),
      ],
    );
  }
}
