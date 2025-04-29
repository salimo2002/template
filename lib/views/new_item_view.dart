import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/convert_operator_text_field.dart';
import 'package:template/widgets/new%20item%20view%20widgets/drop_down_menu_and_details.dart';
import 'package:template/widgets/new%20item%20view%20widgets/row_default_unit.dart';
import 'package:template/widgets/new%20item%20view%20widgets/save_and_exite_button.dart';
import 'package:template/widgets/new%20item%20view%20widgets/text_field_barcode.dart';
import 'package:template/widgets/new%20item%20view%20widgets/text_field_details.dart';
import 'package:template/widgets/new%20item%20view%20widgets/uploaded_image.dart';
import 'package:template/widgets/switch_and_details.dart';

class NewItemView extends StatefulWidget {
  const NewItemView({super.key});
  static String id = 'NewItemView';

  @override
  State<NewItemView> createState() => _NewItemViewState();
}

class _NewItemViewState extends State<NewItemView> {
  final TextEditingController materialName = TextEditingController();
  final TextEditingController baraCode1 = TextEditingController();
  final TextEditingController unit1 = TextEditingController();
  final TextEditingController purchasePrice = TextEditingController();
  final TextEditingController price1 = TextEditingController();
  final TextEditingController unit2 = TextEditingController();
  final TextEditingController unit2Num = TextEditingController();
  final TextEditingController price2 = TextEditingController();
  final TextEditingController baraCode2 = TextEditingController();
  final List<String> categories = ['عام','البسة'];
  final ValueNotifier<int?> isSelected = ValueNotifier<int?>(1);
  final GlobalKey<FormState> globalKey = GlobalKey();
  final ValueNotifier<List<String>> labels = ValueNotifier<List<String>>([
    '',
    '',
    '',
  ]);
  @override
  void initState() {
    unit1.addListener(() {
      unit2Num.text = unit1.text;
      labels.value[0] = unit1.text;
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      labels.notifyListeners();
    });

    unit2.addListener(() {
      labels.value[1] = unit2.text;
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      labels.notifyListeners();
    });

    super.initState();
  }

  @override
  void dispose() {
    unit1.dispose();
    unit2Num.dispose();
    unit2.dispose();
    labels.dispose();
    isSelected.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'مادة جديدة',
        showIcons: false,
      ),
      body: SafeArea(
        child: Form(
          key: globalKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      UploadedImage(),
                      SizedBox(height: 7),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            controller: materialName,
                            hintText: 'اسم المادة',
                            label: '  اسم المادة',
                            validator: (p0) {
                              if (p0 == null || p0.trim().isEmpty) {
                                return '! ادخل اسم المادة';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      ContainerFields(
                        children: [
                          TextFieldAndBarcode(
                            controller: baraCode1,
                            hintText: 'الباركود',
                            label: 'الباركود',
                          ),
                        ],
                      ),
                      ContainerFields(children: [DropDownMenuAndDetails(categories: categories,)]),
                      ContainerFields(
                        children: [
                          SwitchAndDetails(valueSwitch: ValueNotifier(false)),
                        ],
                      ),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            controller: unit1,
                            hintText: 'الوحدة الاولى',
                            label: "الوحدة الاولى",
                          ),
                          SizedBox(height: 5),
                          TextFieldAndDetails(
                            controller: purchasePrice,
                            hintText: 'سعر الشراء',
                            label: "   سعر الشراء",
                            keyType: TextInputType.number,
                          ),
                          SizedBox(height: 5),
                          TextFieldAndDetails(
                            controller: price1,
                            hintText: 'سعر المبيع',
                            label: "   سعر المبيع",
                            keyType: TextInputType.number,
                          ),
                        ],
                      ),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            controller: unit2,
                            hintText: 'الوحدة الثانية',
                            label: "الوحدة الثانية",
                          ),
                          SizedBox(height: 5),
                          ConvertOperatorTextField(
                            textEditingController: unit2Num,
                            label: 'معامل التحويل',
                            hintText: 'معامل التحويل',
                            keyType: TextInputType.number,
                          ),
                          SizedBox(height: 5),
                          TextFieldAndDetails(
                            hintText: 'سعر المبيع',
                            label: '  سعر المبيع',
                            controller: price2,
                            keyType: TextInputType.number,
                          ),
                          SizedBox(height: 5),
                          TextFieldAndBarcode(
                            hintText: 'الباركود',
                            label: 'الباركود',
                            controller: baraCode2,
                          ),
                        ],
                      ),
                      ContainerFields(
                        children: [
                          RowDefaultUnit(
                            labels: labels,
                            isSelected: isSelected,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: SaveAndExitButton(
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      log('message');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
