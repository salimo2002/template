
import 'package:flutter/material.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class RadioDetails extends StatelessWidget {
  const RadioDetails({super.key, required this.valueNotifier});
  final ValueNotifier<bool> valueNotifier;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          Text(
              'قطعة',
              style: FontStyleApp.blackCustom18.copyWith(
                fontSize: getResponsiveText(context, 12),
              ),
            ),
          
          ],
        );
      },
    );
  }
}
