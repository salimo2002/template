import 'package:flutter/material.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/invoice%20details%20view/comments_text_field.dart';
import 'package:template/widgets/invoice%20details%20view/date_picker_field.dart';
import 'package:template/widgets/invoice%20details%20view/radio_menu_buttons.dart';
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
                                    child: RadioMenuButtons(),
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
