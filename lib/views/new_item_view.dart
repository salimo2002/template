import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/container_fields.dart';
import 'package:template/widgets/text_field_barcode.dart';
import 'package:template/widgets/text_field_details.dart';

class NewItemView extends StatelessWidget {
  const NewItemView({super.key});
  static String id = 'NewItemView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'مادة جديدة',
        showIcons: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ContainerFields(
                    children: [
                      TextFieldAndDetails(
                        hintText: 'اسم المادة',
                        label: '  اسم المادة',
                      ),
                    ],
                  ),
                  ContainerFields(
                    children: [
                      TextFieldAndBarcode(
                        hintText: 'الباركود',
                        label: 'الباركود',
                      ),
                    ],
                  ),
                  ContainerFields(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 5),
                          Expanded(
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: DropdownMenu(
                                trailingIcon: SizedBox.shrink(),
                                inputDecorationTheme: InputDecorationTheme(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: kblueAccent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: kblueAccent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: kblueAccent),
                                  ),
                                  filled: true,
                                  fillColor: kWhite,
                                ),
                                width: double.infinity,
                                menuStyle: MenuStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                    kWhite,
                                  ),
                                ),
                                dropdownMenuEntries: [
                                  DropdownMenuEntry<String>(
                                    value: 'البسة',
                                    label: 'عام',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            ' التصنيف',
                            style: TextStyle(
                              fontSize: getResponsiveText(context, 15),
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
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
                        hintText: '',
                        label: "الوحدة الاولى",
                        initValue: 'قطعة',
                      ),
                      SizedBox(height: 5),
                      TextFieldAndDetails(
                        hintText: 'سعر الشراء',
                        label: "   سعر الشراء",
                      ),
                      SizedBox(height: 5),
                      TextFieldAndDetails(
                        hintText: 'سعر المبيع',
                        label: "   سعر المبيع",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                backgroundColor: WidgetStateProperty.all(kblueAccent),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('حفظ وانهاء', style: FontStyleApp.white18),
            ),
          ),
        ],
      ),
    );
  }
}