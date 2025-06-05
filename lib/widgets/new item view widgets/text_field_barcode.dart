import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/new%20item%20view%20widgets/text_field_details.dart';

class TextFieldBaracode extends StatefulWidget {
  const TextFieldBaracode({super.key, required this.controller});
  final TextEditingController controller;
  @override
  State<TextFieldBaracode> createState() => _TextFieldBaracodeState();
}

class _TextFieldBaracodeState extends State<TextFieldBaracode> {
  bool showScanner = false;
  final MobileScannerController scannerController = MobileScannerController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  void _toggleScanner() {
    setState(() {
      showScanner = !showScanner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldAndDetails(
          focusNode: FocusNode(),
          icon: IconButton(
            onPressed: _toggleScanner,
            icon: Icon(FontAwesomeIcons.barcode, size: 20, color: kBlueAccent),
          ),
          controller: widget.controller,
          hintText: 'الباركود',
        ),
        if (showScanner)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 150,
              child: MobileScanner(
                controller: scannerController,
                onDetect: (capture) {
                  final String? code = capture.barcodes.first.rawValue;
                  if (code != null && code.isNotEmpty) {
                    widget.controller.text = code;
                    _playBeepSound();
                    scannerController.stop();
                    setState(() {
                      showScanner = false;
                    });
                  }
                },
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _playBeepSound() async {
    await _audioPlayer.play(AssetSource('sounds/beep.mp3'));
  }
}
