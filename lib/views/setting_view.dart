import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/models/account_model.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});
  static String id = 'SettingView';

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  TextEditingController priceSellInvoice = TextEditingController();
  TextEditingController priceUndosellInvoice = TextEditingController();

  TextEditingController priceBuyInvoice = TextEditingController();
  TextEditingController priceUndobuyInvoice = TextEditingController();
  TextEditingController mainBoxController = TextEditingController();

  FocusNode sellInvoice = FocusNode();
  FocusNode undoSellInvoice = FocusNode();
  FocusNode buyInvoice = FocusNode();
  FocusNode undoBuyInvoice = FocusNode();
  FocusNode mainBox = FocusNode();
  List<AccountModel> searchResults = [];
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'الإعدادات',
        showIcons: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ContainerFields(
                children: [
                  CustomTextField(
                    canRead: true,
                    suffixIcon: InkWell(
                      onTapDown:
                          (details) => showPrice(details, priceSellInvoice),
                      child: Icon(Icons.arrow_drop_down, size: 30),
                    ),
                    hintText: 'سعر فاتورة المبيعات',
                    controller: priceSellInvoice,
                    focusNode: sellInvoice,
                  ),
                  CustomTextField(
                    canRead: true,
                    suffixIcon: InkWell(
                      onTapDown:
                          (details) => showPrice(details, priceUndosellInvoice),
                      child: Icon(Icons.arrow_drop_down, size: 30),
                    ),
                    hintText: 'سعر فاتورة مردود المبيعات',
                    controller: priceUndosellInvoice,
                    focusNode: undoSellInvoice,
                  ),
                  CustomTextField(
                    canRead: true,
                    suffixIcon: InkWell(
                      onTapDown: (details) => showPrice(details, priceBuyInvoice),
                      child: Icon(Icons.arrow_drop_down, size: 30),
                    ),
          
                    hintText: 'سعر فاتورة المشتريات',
                    controller: priceBuyInvoice,
                    focusNode: buyInvoice,
                  ),
                  CustomTextField(
                    canRead: true,
          
                    suffixIcon: InkWell(
                      onTapDown:
                          (details) => showPrice(details, priceUndobuyInvoice),
                      child: Icon(Icons.arrow_drop_down, size: 30),
                    ),
                    hintText: 'سعر فاتورة مردود المشتريات',
                    controller: priceUndobuyInvoice,
                    focusNode: undoBuyInvoice,
                  ),
                ],
              ),
              SizedBox(height: 12),
              ContainerFields(
                children: [
                  CustomTextField(onChanged: (p0) => searchAccount(p0),
                    hintText: 'الصندوق الرئيسي',
                    controller: mainBoxController,
                    focusNode: mainBox,
                  ),
                ],
              ), if (isSearching)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SizedBox(height: MediaQuery.sizeOf(context).height*.3,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: searchResults.length,
                                  itemBuilder: (context, index) {
                                    final account = searchResults[index];
                                    return ListTile(
                                      title: Text(account.accName),
                                      subtitle: Text(account.accKind.toString()),
                                      onTap: () {
                                        setState(() {
                                          mainBoxController.text = account.accName;
                                          isSearching = false;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
            ],
          ),
        ),
      ),
    );
  }

  void showPrice(TapDownDetails details, TextEditingController controller) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      menuPadding: EdgeInsets.zero,
      context: context,
      position: RelativeRect.fromRect(
        details.globalPosition & const Size(60, 60),
        Offset.zero & overlay.size,
      ),
      items: [
        CheckedPopupMenuItem(
          child: Center(child: Text('سعر الجملة')),
          onTap: () {
            controller.text = 'سعر الجملة';
          },
        ),
        CheckedPopupMenuItem(
          child: Center(child: Text('سعر المستهلك')),
          onTap: () {
            controller.text = 'سعر المستهلك';
          },
        ),
      ],
    );
  }

  void searchAccount(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
        isSearching = false;
      });
      return;
    }

    setState(() {
      isSearching = true;
    });

    final accounts = context.read<AccountsCubit>().accounts;
    final results =
        accounts.where((account) {
          return account.accName.toLowerCase().contains(query.toLowerCase());
        }).toList();

    setState(() {
      searchResults = results;
    });
  }
}
