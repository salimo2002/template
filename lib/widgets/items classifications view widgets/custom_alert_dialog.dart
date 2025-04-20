
import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_edit_classifications.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_save.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_text_form_field.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key, required this.initialValue,
  });
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Column(
          children: [
            CustomButtonEditClassifications(onTap: () {}),
            SizedBox(height: 4),
            CustomTextFormField(initialValue: initialValue),
            SizedBox(height: 5,),
            CustomButtonSave(),
          ],
        ),
      ),
      backgroundColor: kWhite,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: kWhite, width: 2),
      ),
    );
  }
}
