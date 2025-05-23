import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/cubit/category%20cubit/category_cubit.dart';
import 'package:template/cubit/material%20cubit/material_cubit.dart';
import 'package:template/cubit/material%20cubit/material_status.dart';
import 'package:template/models/material_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/convert_operator_text_field.dart';
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
  final TextEditingController matCategory = TextEditingController(
    text: 'اختر التصنيف',
  );
  final TextEditingController baraCode1 = TextEditingController();
  final TextEditingController unit1 = TextEditingController();
  int matUnitDef = 1;
  final TextEditingController unitDefault = TextEditingController(
    text: 'اختر الوحدة الافتراضية',
  );
  final TextEditingController purchasePrice = TextEditingController();
  final TextEditingController price1 = TextEditingController();
  final TextEditingController unit2 = TextEditingController();
  final TextEditingController unit2Num = TextEditingController();
  final TextEditingController price2 = TextEditingController();
  final TextEditingController baraCode2 = TextEditingController();
  final TextEditingController convertOperatorTextField =
      TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();
  late int parentId = context.read<CategoryCubit>().categories[0].matId;
  ValueNotifier<String> imageUpdate = ValueNotifier('');

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
    matCategory.dispose();
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
                                  onPressed: () async {
                                    if (globalKey.currentState!.validate()) {
                                      await context
                                          .read<MaterialCubit>()
                                          .insertMaterial(
                                            MaterialModel(
                                              materialUnit: unit1.text,
                                              materialId: 0,
                                              materialNumber:
                                                  Random()
                                                      .nextInt(1000000)
                                                      .toString(),
                                              materialName: materialName.text,
                                              materialCode: baraCode1.text,
                                              materialPrice1:
                                                  double.tryParse(
                                                    purchasePrice.text,
                                                  ) ??
                                                  0.0,
                                              materialPrice3:
                                                  double.tryParse(
                                                    price1.text,
                                                  ) ??
                                                  0.0,
                                              materialUnit2: unit2.text,
                                              materialUnit2Number:
                                                  double.tryParse(
                                                    convertOperatorTextField
                                                        .text,
                                                  ) ??
                                                  1.0,
                                              materialUnit2Price3:
                                                  double.tryParse(
                                                    price2.text,
                                                  ) ??
                                                  0.0,
                                              materialKind: 0,
                                              materialUnitDefault: matUnitDef,
                                              materialImage: imageUpdate.value,
                                              parentId: parentId,
                                              materiaUnit2Baracode:
                                                  baraCode2.text,
                                            ),
                                          );
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    'حفظ',
                                    style: FontStyleApp.black18,
                                  ),
                                ),
                              ],
                            );
                          } else if (state is LoadingState) {
                            return CircularProgressIndicator(
                              color: kBlueAccent,
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
}
