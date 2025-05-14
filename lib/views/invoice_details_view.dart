import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/save_and_exite_button.dart';
import 'package:template/widgets/new%20item%20view%20widgets/text_field_details.dart';

class InvoiceDetailsView extends StatelessWidget {
  const InvoiceDetailsView({super.key});
  static String id = 'InvoiceDetailsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'فاتورة مبيعات جديدة',
        showIcons: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    spacing: 5,
                    children: [
                      Column(
                        children: [
                          CustomContainer(
                            child: Column(
                              spacing: 5,
                              children: [
                                ContainerFields(
                                  children: [
                                    TextFieldAndDetails(
                                      hintText: 'زبون نقدي',
                                      label: 'اسم الحساب',
                                      controller: TextEditingController(),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  child: CustomContainer(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text('الرصيد 0'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      CustomContainer(
                        child: Row(
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomContainer(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RadioMenuButton<int>(
                                          style: ButtonStyle(
                                            visualDensity:
                                                VisualDensity.compact,
                                            overlayColor:
                                                WidgetStateProperty.all(
                                                  Colors.transparent,
                                                ),
                                            iconColor: WidgetStateProperty.all(
                                              kBlueAccent,
                                            ),
                                          ),
                                          value: 1,
                                          groupValue: 1,
                                          onChanged: (value) {},
                                          child: Text('نقدي'),
                                        ),

                                        RadioMenuButton<int>(
                                          style: ButtonStyle(
                                            iconColor: WidgetStateProperty.all(
                                              kBlueAccent,
                                            ),
                                          ),
                                          value: 2,
                                          groupValue: 1,
                                          onChanged: (value) {},
                                          child: Text('اجل'),
                                        ),

                                        RadioMenuButton<int>(
                                          style: ButtonStyle(
                                            iconColor: WidgetStateProperty.all(
                                              kBlueAccent,
                                            ),
                                          ),
                                          value: 3,
                                          groupValue: 1,
                                          onChanged: (value) {},
                                          child: Text('جزئي'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text('نمط الدفع'),
                          ],
                        ),
                      ),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            hintText: 'الصندوق الرئيسي',
                            label: 'الصندوق',
                            controller: TextEditingController(),
                          ),
                        ],
                      ),
                      CustomContainer(
                        child: Column(
                          spacing: 3,
                          children: [
                            SizedBox(height: 5),
                            TextFieldAndDetails(
                              hintText: '0',
                              label: 'مجموع الفواتير',
                              controller: TextEditingController(),
                            ),
                            TextFieldAndDetails(
                              hintText: '0',
                              label: 'حسم ممنوح',
                              controller: TextEditingController(),
                            ),
                            TextFieldAndDetails(
                              hintText: '0',
                              label: 'صافي الفواتير',
                              controller: TextEditingController(),
                            ),
                            TextFieldAndDetails(
                              hintText: '0',
                              label: 'المبلغ المقبوض',
                              controller: TextEditingController(),
                            ),
                            TextFieldAndDetails(
                              hintText: '0',
                              label: 'المبلغ المتبقي',
                              controller: TextEditingController(),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),

                      DatePickerField(),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            keyType: TextInputType.numberWithOptions(),
                            hintText: 'رقم الورقة',
                            label: 'رقم الورقة',
                            controller: TextEditingController(),
                          ),
                        ],
                      ),

                      CustomContainer(
                        child: Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: CustomContainer(
                                  child: CommentsTextField(
                                    maxLines: 4,
                                    hintText: '',
                                    controller: TextEditingController(),
                                  ),
                                ),
                              ),
                            ),
                            Text('ملاحظات'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('طباعة الفاتور ايضا'),
                  Checkbox(value: true, onChanged: (value) {}),
                ],
              ),
            ),
            SaveAndExitButton(onPressed: () {}, text: 'حفظ و انهاء'),
          ],
        ),
      ),
    );
  }
}

class CommentsTextField extends StatelessWidget {
  const CommentsTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyType = TextInputType.text,
    this.validator,
    required this.maxLines,
  });
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyType;
  final String? Function(String?)? validator;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      keyboardType: keyType,
      controller: controller,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        hintTextDirection: TextDirection.rtl,
        hintText: hintText,
        hintStyle: FontStyleApp.blackCustom18.copyWith(
          fontSize: getResponsiveText(context, 12),
        ),
        fillColor: kWhite,
        filled: true,
        enabledBorder: borderStyle(),
        border: borderStyle(),
        focusedBorder: borderStyle(),
        errorBorder: borderErrorStyle(),
        focusedErrorBorder: borderErrorStyle(),
        errorStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(borderSide: BorderSide(color: kBlueAccent));
  }

  OutlineInputBorder borderErrorStyle() {
    return const OutlineInputBorder(borderSide: BorderSide(color: Colors.red));
  }
}

class DatePickerField extends StatefulWidget {
  const DatePickerField({super.key});

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kBlueAccent,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            '${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: InkWell(
                onTap: () => _selectDate(context),
                child: IgnorePointer(
                  child: EditableText(
                    textAlign: TextAlign.end,
                    controller: _dateController,
                    focusNode: FocusNode(),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    cursorColor: Colors.blue,
                    backgroundCursorColor: Colors.transparent,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _selectedDate,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 30),
          const Text('التاريخ'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}
