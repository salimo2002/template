import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/home%20view%20widgets/parts_titel.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';
import 'package:template/widgets/new%20item%20view%20widgets/save_and_exite_button.dart';

class CreateASalesInvoiceView extends StatefulWidget {
  const CreateASalesInvoiceView({super.key});
  static String id = 'CreateASalesInvoice';

  @override
  State<CreateASalesInvoiceView> createState() => _CreateASalesInvoiceViewState();
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    CustomContainer(
                      child: Row(
                        children: [
                          SizedBox(width: 5),
                          Expanded(
                            child: CustomTextField(
                              hintText: 'قم بالبحث عن مادة ',
                              controller: controllerSerch,
                            ),
                          ),
                          SizedBox(width: 5),
                          IconButton(
                            onPressed: _toggleScanner,
                            icon: const Icon(
                              FontAwesomeIcons.barcode,
                              color: kBlueAccent,
                            ),
                          ),
                          SizedBox(width: 5),
                          if (showScanner)
                            SizedBox(
                              height: 300,
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
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        CustomContainer(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'سكر',
                                    style: TextStyle(
                                      fontSize: getResponsiveText(context, 18),
                                    ),
                                  ),
                                  Text(' -1'),
                                  SizedBox(width: 5),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                spacing: 10,
                                children: [
                                  SizedBox(width: 5),
                                  EditableDataColumn(
                                    conttroller: TextEditingController(
                                      text: "1",
                                    ),
                                    text: 'المجموع',
                                  ),
                                  EditableDataColumn(
                                    conttroller: TextEditingController(
                                      text: "1",
                                    ),
                                    text: 'السعر',
                                  ),
                                  EditableDataColumn(
                                    conttroller: TextEditingController(
                                      text: "1",
                                    ),
                                    text: 'الكمية',
                                  ),
                                  Expanded(
                                    child: CustomContainer(
                                      child: Column(
                                        children: [
                                          PartsTitle(
                                            title: 'الوحدة',
                                            color: kBlueAccent,
                                          ),
                                          InkWell(
                                            onTapDown: (details) {
                                              final RenderBox overlay =
                                                  Overlay.of(context).context
                                                          .findRenderObject()
                                                      as RenderBox;
                                              showMenu(
                                                context: context,
                                                position: RelativeRect.fromRect(
                                                  details.globalPosition &
                                                      const Size(60, 60),
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
                                            child: Text('قطعة'),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CustomContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('بنود : 1 |كمية : 0 | مجموع : 5 ل.س')],
              ),
            ),
          ),
          SizedBox(height: 5),
          SaveAndExitButton(onPressed: () {}, text: 'التالي'),
        ],
      ),
    );
  }
}

class EditableDataColumn extends StatelessWidget {
  const EditableDataColumn({
    super.key,
    required this.text,
    required this.conttroller,
    this.onChanged,
  });

  ///Product details
  final String text;
  final TextEditingController conttroller;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomContainer(
        child: Column(
          children: [
            PartsTitle(title: text, color: kBlueAccent),
            EditableText(
              textAlign: TextAlign.center,
              controller: conttroller,
              focusNode: FocusNode(),
              style: TextStyle(fontSize: 16, color: Colors.black),
              cursorColor: Colors.blue,
              backgroundCursorColor: Colors.transparent,
              keyboardType: TextInputType.number,
              onChanged: onChanged,
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
