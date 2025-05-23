import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/cubit/category%20cubit/category_cubit.dart';
import 'package:template/cubit/material%20cubit/material_cubit.dart';
import 'package:template/cubit/material%20cubit/material_status.dart';
import 'package:template/models/material_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/custom_snack_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/convert_operator_text_field.dart';
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
  final TextEditingController unitDefault = TextEditingController();
  final TextEditingController unit1 = TextEditingController();
  final TextEditingController matCategory = TextEditingController();
  final TextEditingController purchasePrice = TextEditingController();
  final TextEditingController price1 = TextEditingController();
  final TextEditingController unit2 = TextEditingController();
  final TextEditingController unit2Num = TextEditingController();
  final TextEditingController price2 = TextEditingController();
  final TextEditingController baraCode2 = TextEditingController();
  // final ValueNotifier<int?> isSelected = ValueNotifier<int?>(1);
  final ValueNotifier<int> selectedKind = ValueNotifier<int>(0);
  final TextEditingController convertOperatorTextField =
      TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();
  int matUnitDef = 1;
  ValueNotifier<String> imageUpdate = ValueNotifier('');
  late MaterialModel argumentsMaterial;
  String materialImagePath = '';
  String? image;
  late int parentId;
  bool _isInit = true;
  @override
  void initState() {
    unit1.addListener(() {
      unit2Num.text = unit1.text;
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
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      log('didChangeDependencies - init');
      argumentsMaterial =
          ModalRoute.of(context)!.settings.arguments as MaterialModel;
      matUnitDef = argumentsMaterial.materialUnitDefault;
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
      matUnitDef == 1
          ? unitDefault.text = unit1.text
          : unitDefault.text = unit2.text;
      context.read<CategoryCubit>().categories.forEach((element) {
        if (argumentsMaterial.parentId == element.matId) {
          matCategory.text = element.matName;
        }
      });

      _isInit = false;
    }
    log(image.toString());
    super.didChangeDependencies();
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
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 20),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            controller: materialName,
                            hintText: 'اسم المادة',
                            validator: (p0) {
                              if (p0 == null || p0.trim().isEmpty) {
                                return '! ادخل اسم المادة';
                              }
                              return null;
                            },
                          ),
                          TextFieldAndDetails(
                            canRead: true,
                            icon: InkWell(
                              onTapDown: showCategory,
                              child: Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 40,
                                color: kBlueAccent,
                              ),
                            ),
                            controller: matCategory,
                            hintText: 'التصنيف',
                          ),
                          TextFieldBaracode(controller: baraCode1),
                        ],
                      ),
                      SizedBox(height: 20),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            controller: unit1,
                            hintText: 'الوحدة الاولى',
                          ),
                          TextFieldAndDetails(
                            controller: purchasePrice,
                            hintText: 'سعر الجملة',
                            keyType: TextInputType.number,
                          ),
                          TextFieldAndDetails(
                            controller: price1,
                            hintText: 'سعر المستهلك',
                            keyType: TextInputType.number,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            controller: unit2,
                            hintText: 'الوحدة الثانية',
                          ),
                          ConvertOperatorTextField(
                            convertOperatorTextField: convertOperatorTextField,
                            textEditingController: unit2Num,
                            hintText: 'معامل التحويل',
                            keyType: TextInputType.number,
                          ),
                          TextFieldAndDetails(
                            hintText: 'سعر المستهلك',
                            controller: price2,
                            keyType: TextInputType.number,
                          ),
                          TextFieldBaracode(controller: baraCode2),
                          TextFieldAndDetails(
                            canRead: true,
                            icon: InkWell(
                              onTapDown: showUnits,
                              child: Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 40,
                                color: kBlueAccent,
                              ),
                            ),
                            controller: unitDefault,
                            hintText: 'الوحدة الافتراضية',
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      BlocConsumer<MaterialCubit, MaterialStatus>(
                        listener: (context, state) {
                          if (state is FaliureState) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              customSnackBar(
                                context,
                                'حدث خطأ اثناء تعديل المادة',
                                kRed,
                              ),
                            );
                          } else if (state is SuccessState) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              customSnackBar(
                                context,
                                'تم تعديل المادة بنجاح',
                                kRed,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is SuccessState) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'الغاء',
                                    style: FontStyleApp.black18,
                                  ),
                                ),
                                TextButton(
                                  onPressed: editMaterial,
                                  child: Text(
                                    'حفظ',
                                    style: FontStyleApp.black18,
                                  ),
                                ),
                              ],
                            );
                          } else if (state is LoadingState) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CircularProgressIndicator(
                                color: kBlueAccent,
                              ),
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
            ],
          ),
        ),
      ),
    );
  }

  void editMaterial() async {
    if (globalKey.currentState!.validate()) {
      await context.read<MaterialCubit>().updateMaterial(
        MaterialModel(
          materialId: argumentsMaterial.materialId,
          materialNumber: argumentsMaterial.materialNumber,
          materialName: materialName.text,
          materialCode: baraCode1.text,
          materialPrice1: double.tryParse(purchasePrice.text) ?? 0.0,
          materialPrice3: double.tryParse(price1.text) ?? 0.0,
          materialUnit: unit1.text,
          materialUnit2: unit2.text,
          materialUnit2Number:
              double.tryParse(convertOperatorTextField.text) ?? 0.0,
          materialUnit2Price3: double.tryParse(price2.text) ?? 0.0,
          materialKind: 0,
          materialUnitDefault: matUnitDef,
          materialImage: materialImagePath,
          parentId: parentId,
          materiaUnit2Baracode: baraCode2.text,
        ),
      );
    }
  }

  void showUnits(TapDownDetails details) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      menuPadding: EdgeInsets.zero,
      context: context,
      position: RelativeRect.fromRect(
        details.globalPosition & const Size(60, 60),
        Offset.zero & overlay.size,
      ),
      items: [
        CheckedPopupMenuItem(
          child: Center(child: Text(unit1.text)),
          onTap: () {
            matUnitDef = 1;
            unitDefault.text = unit1.text;
          },
        ),
        CheckedPopupMenuItem(
          child: Center(child: Text(unit2.text)),
          onTap: () {
            matUnitDef = 2;
            unitDefault.text = unit2.text;
          },
        ),
      ],
    );
  }

  void showCategory(TapDownDetails details) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      menuPadding: EdgeInsets.zero,
      context: context,
      position: RelativeRect.fromRect(
        details.globalPosition & const Size(60, 60),
        Offset.zero & overlay.size,
      ),
      items:
          context.read<CategoryCubit>().categories.map((e) {
            return CheckedPopupMenuItem(
              child: Center(child: Text(e.matName)),
              onTap: () {
                matCategory.text = e.matName;
                parentId = e.matId;
              },
            );
          }).toList(),
    );
  }
}
