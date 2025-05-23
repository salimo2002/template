import 'package:flutter/material.dart';
import 'package:template/widgets/item%20card%20view%20widgets/table_labels.dart';
import 'package:template/widgets/item%20card%20view%20widgets/table_values.dart';

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
                TableLabels(label: 'الكمية المتوفرة'),
                TableLabels(label: 'الكمية المباعة'),
                TableLabels(label: 'الكمية الكلية'),
              ],
            ),
            TableRow(
              children: [
                TableValues(value: '250'),
                TableValues(value: '250'),
                TableValues(value: '250'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
