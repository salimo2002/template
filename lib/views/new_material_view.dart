import 'dart:math';
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

class NewMaterialView extends StatefulWidget {
  const NewMaterialView({super.key});
  static String id = 'NewMaterialView';

  @override
  State<NewMaterialView> createState() => _NewMaterialViewState();
}

class _NewMaterialViewState extends State<NewMaterialView> {
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
  final GlobalKey<FormState> globalKey = GlobalKey();
  late int parentId = context.read<CategoryCubit>().categories[0].matId;
  final ValueNotifier<List<String>> labels = ValueNotifier<List<String>>([
    '',
    '',
    '',
  ]);
  ValueNotifier<String> imageUpdate = ValueNotifier('');

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
    materialName.dispose();
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
                      ValueListenableBuilder<String>(
                        valueListenable: imageUpdate,
                        builder: (context, value, child) {
                          return UploadedImage(
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
                          DropDownMenuAndDetails(
                            value:
                                context.read<CategoryCubit>().categories.isEmpty
                                    ? 'لايوجد تصنيفات'
                                    : context
                                        .read<CategoryCubit>()
                                        .categories[0]
                                        .matName,
                            onChanged: (p0) {
                              context.read<CategoryCubit>().categories.forEach((
                                element,
                              ) {
                                if (p0 == element.matName) {
                                  parentId = element.matId;
                                }
                              });
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
                            label: "   سعر الجملة",
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
                            label: '  معامل التحويل',
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
                  }
                },
                builder: (context, state) {
                  if (state is SuccessState) {
                    return SaveAndExitButton(
                      onPressed: () async {
                        if (globalKey.currentState!.validate()) {
                          await context.read<MaterialCubit>().insertMaterial(
                            MaterialModel(
                              materialUnit: unit1.text,
                              materialId: 0,
                              materialNumber:
                                  Random().nextInt(1000000).toString(),
                              materialName: materialName.text,
                              materialCode: baraCode1.text,
                              materialPrice1:
                                  double.tryParse(purchasePrice.text) ?? 0.0,
                              materialPrice3:
                                  double.tryParse(price1.text) ?? 0.0,
                              materialUnit2: unit2.text,
                              materialUnit2Number:
                                  double.tryParse(
                                    convertOperatorTextField.text,
                                  ) ??
                                  1.0,
                              materialUnit2Price3:
                                  double.tryParse(price2.text) ?? 0.0,
                              materialKind: 0,
                              materialUnitDefault: isSelected.value ?? 1,
                              materialImage: imageUpdate.value,
                              parentId: parentId,
                              materiaUnit2Baracode: baraCode2.text,
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                    );
                  } else if (state is LoadingState) {
                    return CircularProgressIndicator(color: kBlueAccent);
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
