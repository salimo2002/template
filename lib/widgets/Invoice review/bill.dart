import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/Invoice%20review/table_fields_review.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';

class Bill extends StatelessWidget {
  const Bill({
    super.key,
    required this.paymentStyle,
    required this.invoiceNumber,
    required this.billDate,
    required this.billTime,
    required this.nameAccuont,
    required this.total,
    required this.amountPaid,
    required this.reminingAmount,
    required this.note,
    this.billType,
  });

  final String paymentStyle;
  final String invoiceNumber;
  final String billDate;
  final String billTime;
  final String nameAccuont;
  final String total;
  final String amountPaid;
  final String? billType;
  final String reminingAmount;
  final String note;

  @override
  Widget build(BuildContext context) {
    return ContainerFields(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                paymentStyle,

                style: FontStyleApp.blueAccent18.copyWith(
                  fontSize: getResponsiveText(context, 14),
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                '$invoiceNumber : رقم الفاتورة',

                textAlign: TextAlign.center,
                style: FontStyleApp.blueAccent18.copyWith(
                  fontSize: getResponsiveText(context, 14),
                ),
              ),
            ),
            SizedBox(width: 8),
            if (billType != null)
              Expanded(
                child: Text(
                  billType!,

                  textAlign: TextAlign.end,
                  style: FontStyleApp.blueAccent18.copyWith(
                    fontSize: getResponsiveText(context, 14),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                billDate,

                style: FontStyleApp.grey14.copyWith(
                  fontSize: getResponsiveText(context, 14),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                billTime,

                textAlign: TextAlign.center,
                style: FontStyleApp.grey14.copyWith(
                  fontSize: getResponsiveText(context, 14),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                nameAccuont,

                textAlign: TextAlign.end,
                style: FontStyleApp.grey14.copyWith(
                  fontSize: getResponsiveText(context, 14),
                ),
              ),
            ),
          ],
        ),
        Divider(),
        TableFieldsReview(
          lable1: 'المبلغ المتبقي',
          value1: reminingAmount,
          lable2: 'المبلغ المدفوع',
          value2: amountPaid,
          lable3: 'مبلغ الفاتورة',
          value3: total,
        ),
        if (note.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  decodeToUtf8(note),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.visible,
                  style: FontStyleApp.blackCustom18.copyWith(
                    fontSize: getResponsiveText(context, 14),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
