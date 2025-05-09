import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_edit_classifications.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_save.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_text_form_field.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.onTap,
    required this.categoryNameUpdate,
    this.validator,
    required this.globalKey, required this.text,
  });

  final void Function()? onTap;
  final String? Function(String?)? validator;
  final GlobalKey<FormState> globalKey;
  final TextEditingController categoryNameUpdate;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: AlertDialog(
        title: Center(
          child: Column(
            children: [
              CustomButtonEditClassifications(text: text),
              SizedBox(height: 6),
              CustomTextFormField(
                categoryNameUpdate: categoryNameUpdate,
                validator: validator,
              ),
              SizedBox(height: 5),
              CustomButtonSave(onTap: onTap),
            ],
          ),
        ),
        backgroundColor: kWhite,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: kWhite, width: 2),
        ),
      ),
    );
  }
}
