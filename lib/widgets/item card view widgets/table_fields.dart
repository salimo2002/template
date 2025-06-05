import 'package:flutter/material.dart';
import 'package:template/widgets/item%20card%20view%20widgets/table_labels.dart';
import 'package:template/widgets/item%20card%20view%20widgets/table_values.dart';

class TableFIelds extends StatelessWidget {
  const TableFIelds({
    super.key,
    required this.lable1,
    required this.lable2,
    required this.lable3,
    required this.value1,
    required this.value2,
    required this.value3,
    this.lable4,
    this.value4,
  });
  final String lable1;
  final String lable2;
  final String lable3;
  final String? lable4;

  final String value1;
  final String value2;
  final String value3;
  final String? value4;

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
            3: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.white),
              children: [
                TableLabels(label: lable1),
                TableLabels(label: lable2),
                TableLabels(label: lable3),
                lable4 == null ? SizedBox() : TableLabels(label: lable4!),
              ],
            ),
            TableRow(
              children: [
                TableValues(value: value1),
                TableValues(value: value2),
                TableValues(value: value3),
                lable4 != null ? TableValues(value: value4!):SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
