
import 'package:flutter/material.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/sales%20invoice%20view/editable_data_column.dart';

class InvoiceItemCard extends StatelessWidget {
  const InvoiceItemCard({
    super.key,
    required this.context,
    required this.materialName,
    required this.materialNameNumber,
    required this.totalController,
    required this.priceController,
    required this.quantityController,
    required this.unity,
  });

  final BuildContext context;
  final String materialName;
  final String materialNameNumber;
  final TextEditingController totalController;
  final TextEditingController priceController;
  final TextEditingController quantityController;
  final String unity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          CustomContainer(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FittedBox(
                        child: Text(
                          materialName,
                          style: FontStyleApp.black18.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: getResponsiveText(context, 18),
                          ),
                        ),
                      ),

                      FittedBox(
                        child: Text(
                          '  $materialNameNumber',
                          style: FontStyleApp.black18.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: getResponsiveText(context, 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: EditableDataColumn(
                          conttroller: totalController,
                          text: 'المجموع',
                        ),
                      ),

                      Expanded(
                        child: EditableDataColumn(
                          conttroller: priceController,
                          text: 'السعر',
                        ),
                      ),

                      Expanded(
                        child: EditableDataColumn(
                          conttroller: quantityController,
                          text: 'الكمية',
                        ),
                      ),

                      Expanded(
                        child: InkWell(
                          onTapDown: (details) {
                            final RenderBox overlay =
                                Overlay.of(context).context.findRenderObject()
                                    as RenderBox;
                            showMenu(
                              context: context,
                              position: RelativeRect.fromRect(
                                details.globalPosition & const Size(60, 60),
                                Offset.zero & overlay.size,
                              ),
                              items: [
                                PopupMenuItem(
                                  child: ListTile(
                                    title: Text('قطعة'),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  child: ListTile(
                                    title: Text('طرد'),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                          child: EditableDataColumn(
                            text: 'الوحدة',
                            conttroller: TextEditingController(text: unity),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
