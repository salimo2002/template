import 'package:flutter/material.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/text_field_details.dart';

class AddAccountView extends StatelessWidget {
  const AddAccountView({super.key});
  static String id = 'AddAccountView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'الزبائن و الموردون',
        showIcons: false,
      ),
      body: Column(
        children: [
          ContainerFields(
            children: [
              TextFieldAndDetails(
                hintText: 'العملاء و الزبائن',
                label: 'الحساب الرئيسي',
                controller: TextEditingController(),
              ),
            ],
          ),
          ContainerFields(
            children: [
              TextFieldAndDetails(
                hintText: 'اسم الحساب',
                label: 'اسم الحساب',
                controller: TextEditingController(),
              ),
            ],
          ),
          ContainerFields(
            children: [
              TextFieldAndDetails(
                hintText: 'رقم الهاتف',
                label: 'الهاتف',
                controller: TextEditingController(),
              ),
            ],
          ),
          ContainerFields(
            children: [
              TextFieldAndDetails(
                hintText: 'العنوان',
                label: 'العنوان',
                controller: TextEditingController(),
              ),
            ],
          ),
          ContainerFields(
            children: [
              TextFieldAndDetails(
                hintText: 'الرقم الضريبي',
                label: 'الرقم الضريبي',
                controller: TextEditingController(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
