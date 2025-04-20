
import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/responsive_text.dart';

class CustomButtonSave extends StatelessWidget {
  const CustomButtonSave({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
          color: kgrey,
          border: Border.all(color: const Color.fromARGB(255, 138, 137, 137)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(textAlign:TextAlign.center,
          'حفظ',
          style: TextStyle(
            fontSize: getResponsiveText(context, 14),
            color: const Color.fromARGB(
              255,
              82,
              82,
              82,
            ),
          ),
        ),
      ),
    );
  }
}
