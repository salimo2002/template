import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/Service/material_services.dart';
import 'package:template/material%20cubit/material_cubit.dart';
import 'package:template/models/material_model.dart';
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
  final TextEditingController unit111 = TextEditingController();
  final TextEditingController purchasePrice = TextEditingController();
  final TextEditingController price1 = TextEditingController();
  final TextEditingController unit2 = TextEditingController();
  final TextEditingController unit2Num = TextEditingController();
  final TextEditingController price2 = TextEditingController();
  final TextEditingController baraCode2 = TextEditingController();
    final TextEditingController convertOperatorTextField = TextEditingController();


  final List<String> categories = ['عام', 'البسة'];
  final ValueNotifier<int?> isSelected = ValueNotifier<int?>(1);
  final ValueNotifier<int> selectedKind = ValueNotifier<int>(0);

  final GlobalKey<FormState> globalKey = GlobalKey();
  final ValueNotifier<List<String>> labels = ValueNotifier<List<String>>([
    '',
    '',
    '',
  ]);

  String materialImagePath = '';

  @override
  void initState() {
    unit1.addListener(() {
      ModalRoute.of(context)!.settings.arguments;

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
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      UploadedImage(
                        onTap: () async {
                          final picked = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );
                          if (picked != null) {
                            setState(() {
                              materialImagePath = picked.path;
                            });
                          }
                        },
                      ),

                      if (materialImagePath.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(
                            File(materialImagePath),
                            height: 100,
                          ),
                        ),
                      const SizedBox(height: 7),
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
                      ContainerFields(
                        children: [
                          ValueListenableBuilder<int>(
                            valueListenable: selectedKind,
                            builder: (context, value, _) {
                              return DropDownMenuAndDetails(
                                onCTap: (val) {
                                  final newIndex = categories.indexOf(val!);
                                },
                                categories: categories,
                                selectedIndex: value,
                                onChanged: (newIndex) {
                                  selectedKind.value = newIndex!;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      ContainerFields(
                        children: [
                          SwitchAndDetails(valueSwitch: ValueNotifier(false)),
                        ],
                      ),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            controller: unit111,
                            hintText: 'الوحدة الاولى',
                            label: "الوحدة الاولى",
                          ),
                          const SizedBox(height: 5),
                          TextFieldAndDetails(
                            controller: purchasePrice,
                            hintText: 'سعر الشراء',
                            label: "   سعر الشراء",
                            keyType: TextInputType.number,
                          ),
                          const SizedBox(height: 5),
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
                          const SizedBox(height: 5),
                          ConvertOperatorTextField(convertOperatorTextField: convertOperatorTextField,
                            textEditingController: unit2Num,
                            label: 'معامل التحويل',
                            hintText: 'معامل التحويل',
                            keyType: TextInputType.number,
                          ),
                          const SizedBox(height: 5),
                          TextFieldAndDetails(
                            hintText: 'سعر المبيع',
                            label: '  سعر المبيع',
                            controller: price2,
                            keyType: TextInputType.number,
                          ),
                          const SizedBox(height: 5),
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
              SaveAndExitButton(
                onPressed: () async {
                  if (globalKey.currentState!.validate()) {
                    try {
                      final random = Random();
                      final materialNumber = random.nextInt(1000000).toString();

                      final material = MaterialModel(
                        materialUnit: unit111.text,
                        materialId: 0,
                        materialNumber:
                            materialNumber, //////////////هاد الرقم المادة حطيتو عشوائي
                        materialName: materialName.text,
                        materialCode: baraCode1.text,
                        materialPrice1:
                            double.tryParse(purchasePrice.text) ?? 0.0,
                        materialPrice3: double.tryParse(price1.text) ?? 0.0,
                        materialUnit2: unit2.text,
                        materialUnit2Number:
                            double.tryParse(convertOperatorTextField.text) ?? 1.0,
                        materialUnit2Price3:
                            double.tryParse(price2.text) ?? 0.0,
                        materialKind: selectedKind.value,
                        materialUnitDefault: isSelected.value ?? 1,
                        materialImage: materialImagePath,
                        parentId: 0,
                      );
                      await MaterialServices.addMaterial(material);
                      if (!mounted) return;
                      await context.read<MaterialCubit>().fetchMaterials();
                      Navigator.pop(context);
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('فشل في إضافة المادة')),
                        );
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
