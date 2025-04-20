import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/responsive_text.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xfff3f3f3),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black),
          ),
          child: TextFieldBarcode(),
        ),
      ),
    );
  }
}
