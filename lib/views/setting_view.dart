import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/setting%20cubit/setting_cubit.dart';
import 'package:template/cubit/setting%20cubit/setting_state.dart';
import 'package:template/models/account_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/custom_snack_bar.dart';
import 'package:template/views/home_view.dart';
import 'package:template/views/splash_view.dart';
import 'package:template/widgets/log%20in%20view/main_button.dart';
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
  int accId = 1;
  bool isSearching = false;
  bool isRe = true;
  @override
  void didChangeDependencies() {
    if (isRe) {
      context.read<SettingCubit>().settingModel.sellPrice == 0
          ? priceSellInvoice.text = 'سعر الجملة'
          : context.read<SettingCubit>().settingModel.sellPrice == 1
          ? priceSellInvoice.text = 'سعر المستهلك'
          : priceSellInvoice.text = '';
      context.read<SettingCubit>().settingModel.buyPrice == 0
          ? priceBuyInvoice.text = 'سعر الجملة'
          : context.read<SettingCubit>().settingModel.buyPrice == 1
          ? priceBuyInvoice.text = 'سعر المستهلك'
          : priceBuyInvoice.text = '';
      context.read<SettingCubit>().settingModel.undiBuyPrice == 0
          ? priceUndobuyInvoice.text = 'سعر الجملة'
          : context.read<SettingCubit>().settingModel.undiBuyPrice == 1
          ? priceUndobuyInvoice.text = 'سعر المستهلك'
          : priceUndobuyInvoice.text = '';
      context.read<SettingCubit>().settingModel.undoSellPrice == 0
          ? priceUndosellInvoice.text = 'سعر الجملة'
          : context.read<SettingCubit>().settingModel.undoSellPrice == 1
          ? priceUndosellInvoice.text = 'سعر المستهلك'
          : priceUndosellInvoice.text = '';
      context.read<AccountsCubit>().accounts.forEach((element) {
        if (element.accID ==
            context.read<SettingCubit>().settingModel.mainAccount) {
          mainBoxController.text = element.accName;
        }
      });
      isRe = false;
    }
    super.didChangeDependencies();
  }

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
                      onTapDown:
                          (details) => showPrice(details, priceBuyInvoice),
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
                  CustomTextField(
                    onChanged: (p0) => searchAccount(p0),
                    hintText: 'الصندوق الرئيسي',
                    controller: mainBoxController,
                    focusNode: mainBox,
                  ),
                ],
              ),
              if (isSearching)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * .3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
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
                                accId = account.accID!;
                                isSearching = false;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 20),
              BlocConsumer<SettingCubit, SettingState>(
                listener: (context, state) {
                  if (state is SuccesSettingState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(context, 'تم تحديث البيانات', kBlueAccent),
                    );
                    Navigator.pushReplacementNamed(context, SplashView.id);
                  }
                  if (state is FaliureSettingState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      customSnackBar(context, 'حدث خطأ ما لم يتم الحذف', kRed),
                    );
                  }
                },
                builder: (context, state) {
                  return MainButton(
                    onTap: () {
                      context.read<SettingCubit>().updateSetting(
                        buyPrice:
                            priceBuyInvoice.text == 'سعر الجملة' ? '0' : '1',
                        sellPrice:
                            priceSellInvoice.text == 'سعر الجملة' ? '0' : '1',
                        undoBuyPrice:
                            priceUndobuyInvoice.text == 'سعر الجملة'
                                ? '0'
                                : '1',
                        undoSellPrice:
                            priceUndosellInvoice.text == 'سعر الجملة'
                                ? '0'
                                : '1',
                        mainAccount: accId.toString() ?? mainBoxController.text,
                      );
                    },
                    color: kBlueAccent,
                    label: 'حفظ',
                  );
                },
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
