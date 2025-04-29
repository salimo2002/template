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
  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final TextEditingController controllerOne = TextEditingController();
  final TextEditingController controllerTow = TextEditingController();
  final ValueNotifier<int?> isSelected = ValueNotifier<int?>(1);
  final ValueNotifier<List<String>> labels = ValueNotifier<List<String>>([
    '',
    '',
    '',
  ]);
  @override
  void initState() {
    firstController.addListener(() {
      secondController.text = firstController.text;
      labels.value[0] = firstController.text;
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      labels.notifyListeners();
    });

    controllerOne.addListener(() {
      controllerTow.text = controllerOne.text;
      labels.value[1] = controllerOne.text;
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      labels.notifyListeners();
    });

    super.initState();
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    controllerOne.dispose();
    controllerTow.dispose();
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
                          controller: TextEditingController(),
                          hintText: 'اسم المادة',
                          label: '  اسم المادة',
                        ),
                      ],
                    ),
                    ContainerFields(
                      children: [
                        TextFieldAndBarcode(
                          controller: TextEditingController(),
                          hintText: 'الباركود',
                          label: 'الباركود',
                        ),
                      ],
                    ),
                    ContainerFields(children: [DropDownMenuAndDetails()]),
                    ContainerFields(
                      children: [
                        SwitchAndDetails(valueSwitch: ValueNotifier(false)),
                      ],
                    ),
                    ContainerFields(
                      children: [
                        TextFieldAndDetails(
                          controller: firstController,
                          hintText: 'الوحدة الاولى',
                          label: "الوحدة الاولى",
                        ),
                        SizedBox(height: 5),
                        TextFieldAndDetails(
                          controller: TextEditingController(),
                          hintText: 'سعر الشراء',
                          label: "   سعر الشراء",
                        ),
                        SizedBox(height: 5),
                        TextFieldAndDetails(
                          controller: TextEditingController(),
                          hintText: 'سعر المبيع',
                          label: "   سعر المبيع",
                        ),
                      ],
                    ),
                    ContainerFields(
                      children: [
                        TextFieldAndDetails(
                          controller: controllerOne,
                          hintText: 'الوحدة الثانية',
                          label: "الوحدة الثانية",
                        ),
                        SizedBox(height: 5),
                        ConvertOperatorTextField(
                          textEditingController: secondController,
                          label: 'معامل التحويل',
                          hintText: 'معامل التحويل',
                        ),
                        SizedBox(height: 5),
                        TextFieldAndDetails(
                          hintText: 'سعر المبيع',
                          label: '  سعر المبيع',
                          controller: TextEditingController(),
                        ),
                        SizedBox(height: 5),
                        TextFieldAndBarcode(
                          hintText: 'الباركود',
                          label: 'الباركود',
                          controller: TextEditingController(),
                        ),
                      ],
                    ),
                    ContainerFields(
                      children: [
                        RowDefaultUnit(labels: labels, isSelected: isSelected),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: double.infinity, child: SaveAndExitButton()),
          ],
        ),
      ),
    );
  }
}
