import 'package:flutter/material.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class TableFIelds extends StatelessWidget {
  const TableFIelds({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 0.3),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Table(
          border: TableBorder(
            verticalInside: BorderSide(color: Colors.grey.shade400, width: 1),
            horizontalInside: BorderSide(color: Colors.grey.shade400, width: 1),
          ),
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.white),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'الكمية المتوفرة',
                    style: FontStyleApp.blueAccent18.copyWith(
                      fontSize: getResponsiveText(context, 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'الكمية المباعة',
                    style: FontStyleApp.blueAccent18.copyWith(
                      fontSize: getResponsiveText(context, 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'الكمية الكلية',
                    style: FontStyleApp.blueAccent18.copyWith(
                      fontSize: getResponsiveText(context, 14),
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    textAlign: TextAlign.center,
                    '250',
                    style: FontStyleApp.black18.copyWith(
                      fontSize: getResponsiveText(context, 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    textAlign: TextAlign.center,
                    '250',
                    style: FontStyleApp.black18.copyWith(
                      fontSize: getResponsiveText(context, 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    textAlign: TextAlign.center,
                    '250',
                    style: FontStyleApp.black18.copyWith(
                      fontSize: getResponsiveText(context, 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
