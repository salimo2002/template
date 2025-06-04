import 'package:flutter/material.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/views/invoice_review_view.dart';
import 'package:template/widgets/item%20card%20view%20widgets/table_labels.dart';
import 'package:template/widgets/item%20card%20view%20widgets/table_values.dart';

class DetailedAccountStatementView extends StatefulWidget {
  const DetailedAccountStatementView({super.key});
  static String id = 'SupportDetailsViews';

  @override
  State<DetailedAccountStatementView> createState() =>
      _DetailedAccountStatementViewState();
}

class _DetailedAccountStatementViewState
    extends State<DetailedAccountStatementView> {
  TapDownDetails? _tapPosition;

  final TextEditingController accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'كشف حساب',
        showIcons: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Table(
                defaultColumnWidth: const FixedColumnWidth(100),
                border: TableBorder(
                  verticalInside: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                  horizontalInside: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                ),
                children: [
                  const TableRow(
                    decoration: BoxDecoration(color: Colors.white),
                    children: [
                      TableLabels(label: 'الاجمالي'),
                      TableLabels(label: 'سعر الافرادي'),
                      TableLabels(label: 'الكمية'),
                      TableLabels(label: 'البيان'),
                      TableLabels(label: 'التاريخ'),
                      TableLabels(label: 'الرصيد'),
                    ],
                  ),
                  ...List.generate(5, (index) {
                    final isEven = index % 2 == 0;
                    final rowColor =
                        isEven ? Colors.white : Colors.grey.shade200;
                    return buildDataRow(
                      statement: '1',
                      rowColor: rowColor,
                      balance: '3',
                      date: '2024',
                      amount: '6',
                      individualPrice: '1',
                      total: '5000',
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _storeTapPosition(TapDownDetails details) {
    _tapPosition = details;
  }

  void _showPopupMenu() {
    if (_tapPosition == null) return;

    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        _tapPosition!.globalPosition & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          child: const Text('فاتورة'),
          onTap: () {
            Future.delayed(Duration.zero, () {
              Navigator.pushNamed(
                context,
                InvoiceReviewView.id,
                arguments: {
                  'nameAcuont': accountController.text,
                  'billType': 'sell',
                  'title': 'فاتورة....',
                },
              );
            });
          },
        ),
      ],
    );
  }

  TableRow buildDataRow({
    required Color rowColor,
    required String balance,
    required String date,
    required String total,
    required String individualPrice,
    required String amount,
    required String statement,
  }) {
    return TableRow(
      decoration: BoxDecoration(color: rowColor),
      children: List.generate(6, (index) {
        final values = [
          total,
          individualPrice,
          amount,
          statement,
          date,
          balance,
        ];
        return GestureDetector(
          onTapDown: _storeTapPosition,
          onTap: _showPopupMenu,
          behavior: HitTestBehavior.translucent,
          child: TableValues(value: values[index]),
        );
      }),
    );
  }
}
