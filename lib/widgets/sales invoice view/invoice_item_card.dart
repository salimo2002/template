import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
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
    required this.unit1,
    required this.isNumericOnly,
    required this.bounsContoler,
    required this.unit2,
  });

  final BuildContext context;
  final String materialName;
  final String materialNameNumber;
  final TextEditingController totalController;
  final TextEditingController priceController;
  final TextEditingController quantityController;
  final TextEditingController bounsContoler;
  final String unit1;
  final String unit2;
  final bool isNumericOnly;

  @override
  State<InvoiceItemCard> createState() => _InvoiceItemCardState();
}

class _InvoiceItemCardState extends State<InvoiceItemCard> {
  late final TextEditingController unityController;
  bool isUpdating = false;

  final FocusNode focusNodeTotal = FocusNode();
  final FocusNode focusNodeBonus = FocusNode();
  final FocusNode focusNodePrice = FocusNode();
  final FocusNode focusNodeQuantity = FocusNode();

  @override
  void initState() {
    super.initState();

    unityController = TextEditingController(text: widget.unit1);

    widget.priceController.addListener(_onInputChanged);
    widget.quantityController.addListener(_onInputChanged);
    widget.totalController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    widget.priceController.removeListener(_onInputChanged);
    widget.quantityController.removeListener(_onInputChanged);
    widget.totalController.removeListener(_onInputChanged);

    unityController.dispose();

    focusNodeTotal.dispose();
    focusNodeBonus.dispose();
    focusNodePrice.dispose();
    focusNodeQuantity.dispose();

    super.dispose();
  }

  void _onInputChanged() {
    if (isUpdating) return;
    isUpdating = true;

    double price =
        double.tryParse(widget.priceController.text.replaceAll(',', '')) ?? 0;
    double quantity =
        double.tryParse(widget.quantityController.text.replaceAll(',', '')) ??
        0;
    double total =
        double.tryParse(widget.totalController.text.replaceAll(',', '')) ?? 0;

    if (focusNodeTotal.hasFocus) {
      if (quantity > 0) {
        double newPrice = total / quantity;
        newPrice = double.parse(newPrice.toStringAsFixed(2));

        if ((price - newPrice).abs() > 0.01) {
          final cursorPos = widget.priceController.selection;

          widget.priceController.text = newPrice.toStringAsFixed(2);

          final newPos = cursorPos.baseOffset.clamp(
            0,
            widget.priceController.text.length,
          );
          widget.priceController.selection = TextSelection.fromPosition(
            TextPosition(offset: newPos),
          );
        }
      }
    } else if (focusNodePrice.hasFocus || focusNodeQuantity.hasFocus) {
      double newTotal = price * quantity;
      newTotal = double.parse(newTotal.toStringAsFixed(2));

      if ((total - newTotal).abs() > 0.01) {
        final cursorPos = widget.totalController.selection;

        widget.totalController.text = newTotal.toStringAsFixed(2);

        final newPos = cursorPos.baseOffset.clamp(
          0,
          widget.totalController.text.length,
        );
        widget.totalController.selection = TextSelection.fromPosition(
          TextPosition(offset: newPos),
        );
      }
    }

    isUpdating = false;
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
                      const SizedBox(width: 20),
                      InkWell(
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
                                  title: Text(widget.unit1),
                                  onTap: () {
                                    unityController.text = widget.unit1;
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                  title: Text(widget.unit2),
                                  onTap: () {
                                    unityController.text = widget.unit2;
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                        child: Container(
                          width: 90,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: kBlueAccent,
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                unityController.text,
                                style: FontStyleApp.white18.copyWith(
                                  fontSize: getResponsiveText(context, 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      FittedBox(
                        child: Text(
                          widget.materialName,
                          style: FontStyleApp.black18.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: getResponsiveText(context, 14),
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
                          focusNode: focusNodeTotal,
                          conttroller: widget.totalController,
                          text: 'المجموع',
                          isNumericOnly: true,
                        ),
                      ),
                      Expanded(
                        child: EditableDataColumn(
                          focusNode: focusNodeBonus,
                          conttroller: widget.bounsContoler,
                          text: 'الهدايا',
                          isNumericOnly: widget.isNumericOnly,
                        ),
                      ),
                      Expanded(
                        child: EditableDataColumn(
                          focusNode: focusNodePrice,
                          conttroller: widget.priceController,
                          text: 'السعر',
                          isNumericOnly: widget.isNumericOnly,
                        ),
                      ),
                      Expanded(
                        child: EditableDataColumn(
                          focusNode: focusNodeQuantity,
                          conttroller: widget.quantityController,
                          text: 'الكمية',
                          isNumericOnly: widget.isNumericOnly,
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
