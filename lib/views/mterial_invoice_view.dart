import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_status.dart';
import 'package:template/models/bill_details_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/home_view.dart';
import 'package:template/widgets/invoice%20details%20view/bill_details.dart';

class MterialInvoiceView extends StatefulWidget {
  const MterialInvoiceView({super.key});
  static String id = 'MterialInvoiceView';

  @override
  State<MterialInvoiceView> createState() => _MterialInvoiceViewState();
}

class _MterialInvoiceViewState extends State<MterialInvoiceView> {
  List<BillDetailsModel> billDetailes = [];
  List response = [];

  String materialName = '';
  @override
  void didChangeDependencies() {
    response = ModalRoute.of(context)!.settings.arguments as List;
    final materialId = response[0];
    materialName = response[1];
    context.read<BillCubit>().billDetails.forEach((element) {
              log(materialId.toString());

      if (element.matId == materialId) {
        billDetailes.add(element);
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'كشف المادة',
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
                    itemCount: billDetailes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: GestureDetector(
                          onTapDown: (details) {
                            showMenuu(details, billDetailes[index].bilId!);
                          },
                          child: BillDetails(
                            coantaity:
                                billDetailes[index].detQuantity.toString(),
                            pricee:
                                billDetailes[index].detSinglePrice.toString(),
                            invoiceNumber: billDetailes[index].bilId.toString(),
                            bounsy: billDetailes[index].detBouns.toString(),
                            materialName: materialName,

                            total: billDetailes[index].detPrice.toString(),
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
