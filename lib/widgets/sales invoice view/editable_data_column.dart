
import 'package:flutter/material.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';

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
