import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class TextFieldAndBarcode extends StatefulWidget {
  const TextFieldAndBarcode({
    super.key,
    required this.hintText,
    required this.label,
    required this.controller,
  });

  final String hintText;
  final String label;
  final TextEditingController controller;

  @override
  State<TextFieldAndBarcode> createState() => _TextFieldAndBarcodeState();
}

class _TextFieldAndBarcodeState extends State<TextFieldAndBarcode> {
  bool showScanner = false;
  final MobileScannerController scannerController = MobileScannerController();

  void _toggleScanner() {
    setState(() {
      showScanner = !showScanner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: _toggleScanner,
              icon: const Icon(FontAwesomeIcons.barcode, color: kBlueAccent),
            ),
            Expanded(
              child: CustomTextField(
                hintText: widget.hintText,
                controller: widget.controller,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.label,
              style: TextStyle(fontSize: getResponsiveText(context, 12)),
            ),
          ],
        ),
        if (showScanner)
          SizedBox(
            height: 300,
            child: MobileScanner(
              controller: scannerController,
              onDetect: (capture) {
                final String? code = capture.barcodes.first.rawValue;
                if (code != null && code.isNotEmpty) {
                  widget.controller.text = code;
                  scannerController.stop();
                  setState(() {
                    showScanner = false;
                  });
                }
              },
            ),
          ),
      ],
    );
  }
}
