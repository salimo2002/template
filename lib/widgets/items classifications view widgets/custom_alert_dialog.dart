import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_edit_classifications.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_button_save.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_text_form_field.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.onTapSave,
    required this.categoryNameUpdate,
    this.validator,
    required this.globalKey,
    required this.text, this.onTapCancel,
  });

  final void Function()? onTapSave;
  final void Function()? onTapCancel;
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
              Text(
                text,
                style: FontStyleApp.white18.copyWith(
                  color: Colors.black,
                  fontSize: getResponsiveText(context, 14),
                ),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                categoryNameUpdate: categoryNameUpdate,
                validator: validator,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButtonSave(onTap: onTapCancel, label: 'الغاء'),
                  CustomButtonSave(onTap: onTapSave, label: 'حفظ'),
                ],
              ),
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
