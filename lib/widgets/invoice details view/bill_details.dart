import 'package:flutter/material.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/item%20card%20view%20widgets/table_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';

class BillDetails extends StatelessWidget {
  const BillDetails({
    super.key,
    required this.invoiceNumber,
    required this.materialName,
    required this.total,
    required this.pricee,
    required this.coantaity, required this.bounsy,
  });
  final String invoiceNumber;
  final String materialName;

  final String total;
  final String pricee;

  final String coantaity;
    final String bounsy;


  @override
  Widget build(BuildContext context) {
    return ContainerFields(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '$invoiceNumber : رقم الفاتورة',
              style: FontStyleApp.blueAccent18.copyWith(
                fontSize: getResponsiveText(context, 14),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              materialName,
              style: FontStyleApp.grey14.copyWith(
                fontSize: getResponsiveText(context, 14),
              ),
            ),
            
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'المستودع الرئيسي',
              style: FontStyleApp.blackCustom18.copyWith(
                fontSize: getResponsiveText(context, 16),
              ),
            ),
          ],
        ),
        TableFIelds(
          lable1: 'الكمية',
          value1: coantaity,
          lable2: 'السعر الفردي',
          value2: pricee,
          lable3: 'الإجمالي',
          value3: total,
          lable4:'الهدايا' ,
          value4: bounsy,
        ),
      ],
    );
  }
}
