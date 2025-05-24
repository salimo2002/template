import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/invoice_details_view.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';
import 'package:template/widgets/sales%20invoice%20view/editable_data_column.dart';

class CreateASalesInvoiceView extends StatefulWidget {
  const CreateASalesInvoiceView({super.key});
  static String id = 'CreateASalesInvoice';

  @override
  State<CreateASalesInvoiceView> createState() =>
      _CreateASalesInvoiceViewState();
}

class _CreateASalesInvoiceViewState extends State<CreateASalesInvoiceView> {
  bool showScanner = false;

  final MobileScannerController scannerController = MobileScannerController();
  final TextEditingController controller = TextEditingController();
  final TextEditingController controllerSerch = TextEditingController();

  void _toggleScanner() {
    setState(() {
      showScanner = !showScanner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'فاتورة مبيعات جديدة',
        showIcons: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 5),
                              Expanded(
                                child: CustomTextField(
                                  prefixIcon: IconButton(
                                    onPressed: _toggleScanner,
                                    icon: const Icon(
                                      FontAwesomeIcons.barcode,
                                      color: kBlueAccent,
                                    ),
                                  ),
                                  hintText: 'ادخل اسم المادة',
                                  controller: controllerSerch,
                                ),
                              ),
                            ],
                          ),
                          if (showScanner)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                left: 5,
                                right: 5,
                              ),
                              child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: MobileScanner(
                                    controller: scannerController,
                                    onDetect: (capture) {
                                      final String? code =
                                          capture.barcodes.first.rawValue;
                                      if (code != null && code.isNotEmpty) {
                                        controller.text = code;
                                        scannerController.stop();
                                        setState(() {
                                          showScanner = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                      SizedBox(height: 10),
                      InvoiceItemCard(
                        unity: '1',
                        total: '10',
                        context: context,
                        materialName: 'سكر',
                        materialNameNumber: '1',
                        price: '100',
                        quantity: '10',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomContainer(
              borderRadius: BorderRadius.circular(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'بنود : 1 |كمية : 0 | مجموع : 5 ل.س',
                    style: TextStyle(fontSize: getResponsiveText(context, 16)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, InvoiceDetailsView.id);
              },
              child: Text('التالي', style: FontStyleApp.black18),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class InvoiceItemCard extends StatelessWidget {
  const InvoiceItemCard({
    super.key,
    required this.context,
    required this.materialName,
    required this.materialNameNumber,
    required this.total,
    required this.price,
    required this.quantity,
    required this.unity,
  });

  final BuildContext context;
  final String materialName;
  final String materialNameNumber;
  final String total;
  final String price;
  final String quantity;
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
                          conttroller: TextEditingController(text: total),
                          text: 'المجموع',
                        ),
                      ),

                      Expanded(
                        child: EditableDataColumn(
                          conttroller: TextEditingController(text: price),
                          text: 'السعر',
                        ),
                      ),

                      Expanded(
                        child: EditableDataColumn(
                          conttroller: TextEditingController(text: quantity),
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
                            conttroller: TextEditingController(text: 'قطعة'),
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
