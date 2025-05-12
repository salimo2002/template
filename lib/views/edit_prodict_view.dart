import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/category%20cubit/category_cubit.dart';
import 'package:template/material%20cubit/material_cubit.dart';
import 'package:template/material%20cubit/material_status.dart';
import 'package:template/models/material_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/convert_operator_text_field.dart';
import 'package:template/widgets/new%20item%20view%20widgets/drop_down_menu_and_details.dart';
import 'package:template/widgets/new%20item%20view%20widgets/row_default_unit.dart';
import 'package:template/widgets/new%20item%20view%20widgets/save_and_exite_button.dart';
import 'package:template/widgets/new%20item%20view%20widgets/text_field_barcode.dart';
import 'package:template/widgets/new%20item%20view%20widgets/text_field_details.dart';
import 'package:template/widgets/new%20item%20view%20widgets/uploaded_image.dart';

class EditProdictView extends StatefulWidget {
  const EditProdictView({super.key});
  static String id = 'EditProdictView';

  @override
  State<EditProdictView> createState() => _NewItemViewState();
}

class _NewItemViewState extends State<EditProdictView> {
  final TextEditingController materialName = TextEditingController();
  final TextEditingController baraCode1 = TextEditingController();
  final TextEditingController unit1 = TextEditingController();
  final TextEditingController purchasePrice = TextEditingController();
  final TextEditingController price1 = TextEditingController();
  final TextEditingController unit2 = TextEditingController();
  final TextEditingController unit2Num = TextEditingController();
  final TextEditingController price2 = TextEditingController();
  final TextEditingController baraCode2 = TextEditingController();
  final TextEditingController convertOperatorTextField =
      TextEditingController();

  final ValueNotifier<int?> isSelected = ValueNotifier<int?>(1);
  final ValueNotifier<int> selectedKind = ValueNotifier<int>(0);
  final ValueNotifier<int> newCategoryMatId = ValueNotifier<int>(
    0,
  ); ////////////
  final GlobalKey<FormState> globalKey = GlobalKey();
  final ValueNotifier<List<String>> labels = ValueNotifier<List<String>>([
    '',
    '',
    '',
  ]);
  ValueNotifier<String> imageUpdate = ValueNotifier('');
  late MaterialModel argumentsMaterial;
  String materialImagePath = '';
  String image = '';
  String category = '';
  @override
  void initState() {
    unit1.addListener(() {
      unit2Num.text = unit1.text;
      labels.value[0] = unit1.text;
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      labels.notifyListeners();
      newCategoryMatId.addListener(() {});
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
    materialName.dispose();
    convertOperatorTextField.dispose();
    baraCode1.dispose();
    purchasePrice.dispose();
    price1.dispose();
    unit1.dispose();
    price2.dispose();
    baraCode2.dispose();
    unit2Num.dispose();
    unit2.dispose();
    labels.dispose();
    isSelected.dispose();
    newCategoryMatId.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    argumentsMaterial =
        ModalRoute.of(context)!.settings.arguments as MaterialModel;
    isSelected.value = argumentsMaterial.materialUnitDefault;
    materialName.text = argumentsMaterial.materialName;
    baraCode1.text = argumentsMaterial.materialCode;
    baraCode2.text = argumentsMaterial.materiaUnit2Baracode;
    unit1.text = argumentsMaterial.materialUnit;
    unit2.text = argumentsMaterial.materialUnit2;
    purchasePrice.text = argumentsMaterial.materialPrice1.toString();
    price1.text = argumentsMaterial.materialPrice3.toString();
    price2.text = argumentsMaterial.materialUnit2Price3.toString();
    unit2Num.text = argumentsMaterial.materialUnit.toString();
    convertOperatorTextField.text =
        argumentsMaterial.materialUnit2Number.toString();
    image = argumentsMaterial.materialImage;
    final ValueNotifier<int> newCategoryMatId = ValueNotifier(0);

    newCategoryMatId.value = argumentsMaterial.parentId;
    context.read<CategoryCubit>().categories.forEach((element) {
      if (argumentsMaterial.parentId == element.matId) {
        category = element.matName;
      }
    });
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
                      ValueListenableBuilder<String>(
                        valueListenable: imageUpdate,
                        builder: (context, value, child) {
                          return UploadedImage(
                            image: image,
                            url: imageUpdate.value,
                            onTap: () async {
                              final picked = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );
                              if (picked != null) {
                                imageUpdate.value = picked.path;
                              }
                            },
                          );
                        },
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
                                value: category,
                                onChanged: (categoryName) {
                                  if (categoryName != null) {
                                    final categoryCubit =
                                        context.read<CategoryCubit>();
                                    final selectedCategory = categoryCubit
                                        .categories
                                        .firstWhere(
                                          (element) =>
                                              categoryName == element.matName,
                                          orElse:
                                              () =>
                                                  categoryCubit
                                                      .categories
                                                      .first,
                                        );

                                    newCategoryMatId.value =
                                        selectedCategory.matId;

                                    category = categoryName;
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            controller: unit1,
                            hintText: 'الوحدة الاولى',
                            label: "الوحدة الاولى",
                          ),
                          const SizedBox(height: 5),
                          TextFieldAndDetails(
                            controller: purchasePrice,
                            hintText: 'سعر الجملة',
                            label: "سعر الجملة",
                            keyType: TextInputType.number,
                          ),
                          const SizedBox(height: 5),
                          TextFieldAndDetails(
                            controller: price1,
                            hintText: 'سعر المستهلك',
                            label: "سعر المستهلك",
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
                            hintText: 'سعر المستهلك',
                            label: 'سعر المستهلك',
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
              BlocConsumer<MaterialCubit, MaterialStatus>(
                listener: (context, state) {
                  if (state is FaliureState) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: kRed,
                        content: Text(
                          'حدث خطأ أثناء الإضافة',
                          style: FontStyleApp.white18.copyWith(
                            fontSize: getResponsiveText(context, 12),
                          ),
                        ),
                      ),
                    );
                  } else if (state is SuccessState) {
                    log('Final Category ID: ${newCategoryMatId.value}');
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: kBlueAccent,
                        content: Text(
                          'تم تعديل المادة بنجاح',
                          style: FontStyleApp.white18.copyWith(
                            fontSize: getResponsiveText(context, 12),
                          ),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SuccessState) {
                    return SaveAndExitButton(
                      onPressed: () async {
                        if (globalKey.currentState!.validate()) {
                          await context.read<MaterialCubit>().updateMaterial(
                            MaterialModel(
                              materialId: argumentsMaterial.materialId,
                              materialNumber: argumentsMaterial.materialNumber,
                              materialName: materialName.text,
                              materialCode: baraCode1.text,
                              materialPrice1:
                                  double.tryParse(purchasePrice.text) ?? 0.0,
                              materialPrice3:
                                  double.tryParse(price1.text) ?? 0.0,
                              materialUnit: unit1.text,
                              materialUnit2: unit2.text,
                              materialUnit2Number:
                                  double.tryParse(
                                    convertOperatorTextField.text,
                                  ) ??
                                  0.0,
                              materialUnit2Price3:
                                  double.tryParse(price2.text) ?? 0.0,
                              materialKind: 0,
                              materialUnitDefault: isSelected.value ?? 1,
                              materialImage: materialImagePath,
                              parentId:
                                  newCategoryMatId.value == 0
                                      ? argumentsMaterial.parentId
                                      : newCategoryMatId.value,
                              materiaUnit2Baracode: baraCode2.text,
                            ),
                          );
                        }
                      },
                    );
                  } else if (state is LoadingState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CircularProgressIndicator(color: kBlueAccent),
                    );
                  } else {
                    return SizedBox();
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
