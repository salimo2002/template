import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/widgets/container_fields.dart';
import 'package:template/widgets/text_field_barcode.dart';
import 'package:template/widgets/text_field_details.dart';

class NewItemView extends StatelessWidget {
  const NewItemView({super.key});
  static String id = 'NewItemView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'مادة جديدة',
        showIcons: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ContainerFields(
                    children: [
                      TextFieldDetails(
                        hintText: 'اسم المادة',
                        label: 'اسم المادة',
                      ),
                      SizedBox(height: 10),
                      TextFieldBarcode(hintText: 'الباركود', label: 'الباركود'),
                    ],
                  ),
                  ContainerFields(
                    children: [
                      TextFieldDetails(
                        hintText: 'اسم المادة',
                        label: 'اسم المادة',
                      ),
                      SizedBox(height: 10),
                      TextFieldBarcode(hintText: 'الباركود', label: 'الباركود'),
                    ],
                  ),
                  ContainerFields(
                    children: [
                      TextFieldDetails(
                        hintText: 'اسم المادة',
                        label: 'اسم المادة',
                      ),
                      SizedBox(height: 10),
                      TextFieldBarcode(hintText: 'الباركود', label: 'الباركود'),
                    ],
                  ),
                  ContainerFields(
                    children: [
                      TextFieldDetails(
                        hintText: 'اسم المادة',
                        label: 'اسم المادة',
                      ),
                      SizedBox(height: 10),
                      TextFieldBarcode(hintText: 'الباركود', label: 'الباركود'),
                    ],
                  ),
                  ContainerFields(
                    children: [
                      TextFieldDetails(
                        hintText: 'اسم المادة',
                        label: 'اسم المادة',
                      ),
                      SizedBox(height: 10),
                      TextFieldBarcode(hintText: 'الباركود', label: 'الباركود'),
                    ],
                  ),
                  ContainerFields(
                    children: [
                      TextFieldDetails(
                        hintText: 'اسم المادة',
                        label: 'اسم المادة',
                      ),
                      SizedBox(height: 10),
                      TextFieldBarcode(hintText: 'الباركود', label: 'الباركود'),
                    ],
                  ),
                  ContainerFields(
                    children: [
                      TextFieldDetails(
                        hintText: 'اسم المادة',
                        label: 'اسم المادة',
                      ),
                      SizedBox(height: 10),
                      TextFieldBarcode(hintText: 'الباركود', label: 'الباركود'),
                    ],
                  ),
                  ContainerFields(
                    children: [
                      TextFieldDetails(
                        hintText: 'اسم المادة',
                        label: 'اسم المادة',
                      ),
                      SizedBox(height: 10),
                      TextFieldBarcode(hintText: 'الباركود', label: 'الباركود'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                backgroundColor: WidgetStateProperty.all(kblueAccent),
              ),
              onPressed: () {},
              child: Text('حفظ وانهاء', style: FontStyleApp.white18),
            ),
          ),
        ],
      ),
    );
  }
}
