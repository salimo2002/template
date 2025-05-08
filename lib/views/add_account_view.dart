import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/home%20view%20widgets/parts_titel.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
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
              SizedBox(height: 10),
              CustomContainer(
                child: Column(
                  children: [
                    PartsTitle(title: 'الرصيد الافتتاحي', color: kBlueAccent),
                    SizedBox(height: 5),
                    TextFieldAndDetails(
                      hintText: '0',
                      label: 'مدين',
                      controller: TextEditingController(),
                      keyType: TextInputType.numberWithOptions(),
                    ),
                    SizedBox(height: 5),
                    TextFieldAndDetails(
                      hintText: '0',
                      label: 'دائن',
                      controller: TextEditingController(),
                      keyType: TextInputType.numberWithOptions(),
                    ),
                    SizedBox(height: 5),
                    TextFieldAndDetails(
                      keyType: TextInputType.numberWithOptions(),
                      hintText: '0',
                      label: 'الرصيد الافتتاحي',
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
