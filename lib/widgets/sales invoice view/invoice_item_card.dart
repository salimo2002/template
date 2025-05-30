import 'package:flutter/material.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/sales%20invoice%20view/editable_data_column.dart';

class InvoiceItemCard extends StatefulWidget {
  const InvoiceItemCard({
    super.key,
    required this.context,
    required this.materialName,
    required this.materialNameNumber,
    required this.totalController,
    required this.priceController,
    required this.quantityController,
    required this.unity,
    required this.isNumericOnly, required this.bounsContoler,
  });

  final BuildContext context;
  final String materialName;
  final String materialNameNumber;
  final TextEditingController totalController;
  final TextEditingController priceController;
  final TextEditingController quantityController;
  final TextEditingController bounsContoler;

  final String unity;
  final bool isNumericOnly;

  @override
  State<InvoiceItemCard> createState() => _InvoiceItemCardState();
}

class _InvoiceItemCardState extends State<InvoiceItemCard> {
  late final TextEditingController unityController;
  bool isUpdating = false;
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final FocusNode focusNode5 = FocusNode();
  @override
  void initState() {
    super.initState();

    unityController = TextEditingController(text: widget.unity);

    widget.priceController.addListener(updateTotal);
    widget.quantityController.addListener(updateTotal);
    widget.totalController.addListener(updatePriceFromTotal);
  }

  void updateTotal() {
    if (isUpdating) return;
    isUpdating = true;

    final price = double.tryParse(widget.priceController.text);
    final quantity = double.tryParse(widget.quantityController.text);

    if (price != null && quantity != null) {
      widget.totalController.text = (price * quantity).toStringAsFixed(2);
    }

    isUpdating = false;
  }

  void updatePriceFromTotal() {
    if (isUpdating) return;
    isUpdating = true;

    final total = double.tryParse(widget.totalController.text);
    final quantity = double.tryParse(widget.quantityController.text);

    if (total != null && quantity != null && quantity != 0) {
      widget.priceController.text = (total / quantity).toStringAsFixed(2);
    }

    isUpdating = false;
  }

  @override
  void dispose() {
    widget.priceController.removeListener(updateTotal);
    widget.quantityController.removeListener(updateTotal);
    widget.totalController.removeListener(updatePriceFromTotal);
    unityController.dispose();
    super.dispose();
  }

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
                          widget.materialName,
                          style: FontStyleApp.black18.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: getResponsiveText(context, 18),
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          '  ${widget.materialNameNumber}',
                          style: FontStyleApp.black18.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: getResponsiveText(context, 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: EditableDataColumn(
                          focusNode: focusNode1,
                          conttroller: widget.totalController,
                          text: 'المجموع',
                          isNumericOnly: true,
                        ),
                      ),
                      Expanded(
                        child: EditableDataColumn(
                          focusNode: focusNode5,
                          conttroller: widget.bounsContoler,
                          text: 'الهدايا',
                          isNumericOnly: widget.isNumericOnly,
                        ),
                      ),
                      Expanded(
                        child: EditableDataColumn(
                          focusNode: focusNode2,
                          conttroller: widget.priceController,
                          text: 'السعر',
                          isNumericOnly: widget.isNumericOnly,
                        ),
                      ),
                      Expanded(
                        child: EditableDataColumn(
                          focusNode: focusNode3,
                          conttroller: widget.quantityController,
                          text: 'الكمية',
                          isNumericOnly: widget.isNumericOnly,
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
                                    title: const Text('قطعة'),
                                    onTap: () {
                                      unityController.text = 'قطعة';
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  child: ListTile(
                                    title: const Text('طرد'),
                                    onTap: () {
                                      unityController.text = 'طرد';
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                          child: EditableDataColumn(
                            focusNode: focusNode4,
                            text: 'الوحدة',
                            conttroller: unityController,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
