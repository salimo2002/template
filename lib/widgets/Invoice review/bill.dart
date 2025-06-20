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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              paymentStyle,
              style: FontStyleApp.blueAccent18.copyWith(
                fontSize: getResponsiveText(context, 14),
              ),
            ),
            Text(
              '$invoiceNumber : رقم الفاتورة',
              style: FontStyleApp.blueAccent18.copyWith(
                fontSize: getResponsiveText(context, 14),
              ),
            ),
            Text(
              billType ?? '',
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
              billDate,
              style: FontStyleApp.grey14.copyWith(
                fontSize: getResponsiveText(context, 14),
              ),
            ),
            Text(
              billTime,
              style: FontStyleApp.grey14.copyWith(
                fontSize: getResponsiveText(context, 14),
              ),
            ),
            Text(
              nameAccuont,
              style: FontStyleApp.grey14.copyWith(
                fontSize: getResponsiveText(context, 14),
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
        note == ''
            ? SizedBox.shrink()
            : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  decodeToUtf8(note),
                  style: FontStyleApp.blackCustom18.copyWith(
                    fontSize: getResponsiveText(context, 16),
                  ),
                ),
              ],
            ),
      ],
    );
  }
}
