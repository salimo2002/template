import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_status.dart';
import 'package:template/models/bill_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/home_view.dart';
import 'package:template/widgets/Invoice%20review/bill.dart';

class InvoiceReviewView extends StatefulWidget {
  const InvoiceReviewView({super.key});
  static String id = 'InvoiceReviewView';

  @override
  State<InvoiceReviewView> createState() => _InvoiceReviewViewState();
}

class _InvoiceReviewViewState extends State<InvoiceReviewView> {
  late String nameAcuont;
  late String billType;
  late Map mapModalRoute;
  List<BillModel> bill = [];
  double billAmound = 0;
  @override
  void didChangeDependencies() {
    mapModalRoute = ModalRoute.of(context)!.settings.arguments as Map;
    bill=[];
    nameAcuont = mapModalRoute['nameAcuont'];
    billType = mapModalRoute['billType'];
      context.read<BillCubit>().bill.forEach((element) {
        if (element.bilKind == billType) {
          bill.add(element);
        }
      });
    
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: mapModalRoute['title'],
        showIcons: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          BlocBuilder<BillCubit, BillStatus>(
            builder: (context, state) {
              if (state is SuccessStateBill) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: bill.length,
                    itemBuilder: (context, index) {
                      billAmound =
                          bill[index].bilNet! - bill[index].bilPayment!;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: GestureDetector(
                          onTapDown: (details) {
                            showMenuu(details, bill[index].bilId!);
                          },
                          child: Bill(
                            paymentStyle:
                                bill[index].bilPayment == 1 ? 'نقدي' : 'آجل؟',
                            invoiceNumber: bill[index].bilId.toString(),
                            billDate: '2025-5-1',
                            billTime: '5:00 PM',
                            nameAccuont:
                                context
                                    .read<AccountsCubit>()
                                    .accounts
                                    .where(
                                      (element) =>
                                          element.accID == bill[index].accId,
                                    )
                                    .first
                                    .accName,
                            total: bill[index].bilTotal.toString(),
                            amountPaid: bill[index].bilPayment.toString(),
                            reminingAmount: billAmound.toString(),
                            note: 'ملاحظة',
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is LoadingStateBill) {
                return Center(child: CircularProgressIndicator());
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
                      SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomeView.id,
                            (route) => false,
                          );
                        },
                        icon: Icon(Icons.refresh, color: kBlueAccent, size: 40),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void showMenuu(TapDownDetails details, int id) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      menuPadding: EdgeInsets.zero,
      context: context,
      position: RelativeRect.fromRect(
        details.globalPosition & const Size(60, 60),
        Offset.zero & overlay.size,
      ),
      items: [
        CheckedPopupMenuItem(child: Center(child: Text('تعديل')), onTap: () {}),
        CheckedPopupMenuItem(
          child: Center(child: Text('حذف')),
          onTap: () {
            context.read<BillCubit>().billDeletById(id: id);
          },
        ),
      ],
    );
  }
}
