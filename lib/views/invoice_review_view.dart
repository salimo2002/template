import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_status.dart';
import 'package:template/models/account_model.dart';
import 'package:template/models/bill_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/create_a_sales_invoice_view.dart';
import 'package:template/views/home_view.dart';
import 'package:template/widgets/Invoice%20review/bill.dart';
import 'package:template/widgets/invoice%20details%20view/radio_menu_buttons.dart';

class InvoiceReviewView extends StatefulWidget {
  const InvoiceReviewView({super.key});
  static String id = 'InvoiceReviewView';

  @override
  State<InvoiceReviewView> createState() => _InvoiceReviewViewState();
}

class _InvoiceReviewViewState extends State<InvoiceReviewView> {
  int? nameAcuont;
  String? billType;
  Map? mapModalRoute;
  String? date;
  bool isMonth = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    mapModalRoute = ModalRoute.of(context)!.settings.arguments as Map?;

    nameAcuont = mapModalRoute?['nameAcuont'];
    billType = mapModalRoute?['billType'];
    date = mapModalRoute?['dateTime'];
    isMonth = mapModalRoute?['isMonth'] ?? false;
  }

  AccountModel? findAccount(List<AccountModel> accounts, int? accId) {
    if (accId == null) return null;
    for (var acc in accounts) {
      if (acc.accID == accId) return acc;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: mapModalRoute?['title'] ?? 'استعراض الفواتير',
        showIcons: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<BillCubit, BillStatus>(
              builder: (context, state) {
                if (state is SuccessStateBill) {
                  final bills = context.read<BillCubit>().bill;

                  if (billType == null) {
                    return Center(
                      child: Text(
                        'معطيات غير مكتملة لعرض الفواتير',
                        style: FontStyleApp.black18.copyWith(
                          fontSize: getResponsiveText(context, 18),
                        ),
                      ),
                    );
                  }

                  List<BillModel> filteredBills =
                      bills.where((bill) {
                        if (bill.bilDate == null) return false;

                        final matchesKind = bill.bilKind == billType;
                        final matchesPayType =
                            RadioMenuButtons.payType == bill.payType;
                        final matchesAccount =
                            (nameAcuont == null || nameAcuont == 0) ||
                            (bill.accId == nameAcuont);
                        return matchesKind && matchesPayType && matchesAccount;
                      }).toList();

                  if (filteredBills.isEmpty) {
                    return Center(
                      child: Text(
                        'لا توجد فواتير لعرضها',
                        style: FontStyleApp.black18.copyWith(
                          fontSize: getResponsiveText(context, 18),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredBills.length,
                    itemBuilder: (context, index) {
                      final currentBill = filteredBills[index];
                      final billAmount =
                          (currentBill.bilNet ?? 0) -
                          (currentBill.bilPayment ?? 0);

                      final account = findAccount(
                        context.read<AccountsCubit>().accounts,
                        currentBill.accId,
                      );
                      final accountName = account?.accName ?? 'غير معروف';

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Bill(
                          onPressedUP: () {
                            Navigator.pushNamed(
                              context,
                              CreateASalesInvoiceView.id,
                              arguments: {
                                'bill': currentBill,
                                'isNew': false,
                                'BillType': '',
                                'cur_id': currentBill.curId,
                              },
                            );
                          },
                          onPressedDel: () {
                            context.read<BillCubit>().billDeletById(
                              id: currentBill.bilId!,
                            );
                          },
                          paymentStyle:
                              currentBill.payType == 0 ? 'نقدي' : 'آجل',
                          invoiceNumber: currentBill.bilId.toString(),
                          billDate:
                              '${currentBill.bilDate!.year}-${currentBill.bilDate!.month}-${currentBill.bilDate!.day}',
                          billTime:
                              '${currentBill.bilDate!.hour.toString().padLeft(2, '0')}:${currentBill.bilDate!.minute.toString().padLeft(2, '0')}',
                          nameAccuont: accountName,
                          total: currentBill.bilTotal.toString(),
                          amountPaid: currentBill.bilPayment.toString(),
                          reminingAmount: billAmount.toString(),
                          note: currentBill.bilNote ?? '',
                        ),
                      );
                    },
                  );
                } else if (state is LoadingStateBill) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'حدث خطأ حاول مجددا',
                          style: FontStyleApp.black18.copyWith(
                            fontSize: getResponsiveText(context, 18),
                          ),
                        ),
                        const SizedBox(height: 10),
                        IconButton(
                          onPressed: () {
                            context.read<BillCubit>().fetchBills();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              HomeView.id,
                              (route) => false,
                            );
                          },
                          icon: const Icon(
                            Icons.refresh,
                            color: kBlueAccent,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void showMenuu(TapDownDetails details, int id, BillModel selectedBill) {
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
          child: const Center(child: Text('تعديل')),
          onTap: () {
            Future.delayed(Duration.zero, () {
              Navigator.pushNamed(
                context,
                CreateASalesInvoiceView.id,
                arguments: {
                  'bill': selectedBill,
                  'isNew': false,
                  'BillType': '',
                  'cur_id': selectedBill.curId,
                },
              );
            });
          },
        ),
        CheckedPopupMenuItem(
          child: const Center(child: Text('حذف')),
          onTap: () {
            context.read<BillCubit>().billDeletById(id: id);
          },
        ),
      ],
    );
  }
}
