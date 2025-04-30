import 'dart:developer';
import 'dart:io';
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

class EditProdictView extends StatefulWidget {
  const EditProdictView({super.key});
  static String id = 'S';

  @override
  State<EditProdictView> createState() => _NewItemViewState();
}

class _NewItemViewState extends State<EditProdictView> {
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

  final TextEditingController convertOperatorTextField =
      TextEditingController();
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final argumentsMaterial =
        ModalRoute.of(context)!.settings.arguments as MaterialModel;
    materialName.text = argumentsMaterial.materialName;
    baraCode1.text = argumentsMaterial.materialCode;
    unit111.text = argumentsMaterial.materialUnit;
    purchasePrice.text = argumentsMaterial.materialPrice1.toString();
    price1.text = argumentsMaterial.materialPrice3.toString();
    unit2.text = argumentsMaterial.materialUnit2;
    unit2Num.text = argumentsMaterial.materialUnit2Number.toString();
    price2.text = argumentsMaterial.materialPrice3.toString();
    price2.text = argumentsMaterial.materialCode.toString();
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
                          ConvertOperatorTextField(
                            convertOperatorTextField: convertOperatorTextField,
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
                  if (!globalKey.currentState!.validate()) return;

                  final argumentsMaterial =
                      ModalRoute.of(context)!.settings.arguments
                          as MaterialModel;

                  MaterialModel updatedMaterial = MaterialModel(
                    materialId: argumentsMaterial.materialId,
                    materialNumber: baraCode1.text,
                    materialName: materialName.text,
                    materialCode: baraCode1.text,
                    materialPrice1: double.tryParse(purchasePrice.text) ?? 0.0,
                    materialPrice3: double.tryParse(price1.text) ?? 0.0,
                    materialUnit: unit111.text,
                    materialUnit2: unit2.text,
                    materialUnit2Number: double.tryParse(convertOperatorTextField.text) ?? 0.0,
                    materialUnit2Price3: double.tryParse(price2.text) ?? 0.0,
                    materialKind: selectedKind.value,
                    materialUnitDefault: isSelected.value ?? 1,
                    materialImage: materialImagePath,
                    parentId: argumentsMaterial.parentId,
                  );

                  try {
                    bool success = await MaterialServices.updateMaterialById(
                      argumentsMaterial.materialId,
                      updatedMaterial,
                    );

                    if (success) {
                      await context.read<MaterialCubit>().fetchMaterials();
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('فشل في تحديث المادة')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
                    log(e.toString());
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
