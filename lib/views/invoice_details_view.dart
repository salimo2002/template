import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/invoice%20details%20view/comments_text_field.dart';
import 'package:template/widgets/invoice%20details%20view/radio_menu_buttons.dart';
import 'package:template/widgets/invoice%20details%20view/text_field_date.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/text_field_details.dart';

class InvoiceDetailsView extends StatelessWidget {
  const InvoiceDetailsView({super.key});
  static String id = 'InvoiceDetailsView';

  @override
  Widget build(BuildContext context) {
    TextEditingController date = TextEditingController();
    TextEditingController hour = TextEditingController();
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'فاتورة مبيعات جديدة',
        showIcons: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                ContainerFields(
                  children: [
                    TextFieldAndDetails(
                      controller: TextEditingController(),
                      icon: const Icon(Icons.close),
                      hintText: 'اسم الحساب',
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kWhite,
                      ),
                      height: 30,
                      width: MediaQuery.sizeOf(context).width * 0.77,
                      child: Center(
                        child: Text(
                          'الرصيد: 2500',
                          style: FontStyleApp.black18.copyWith(
                            fontSize: getResponsiveText(context, 14),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.sizeOf(context).width * 0.77,
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: const Padding(
                              padding: EdgeInsets.all(1),
                              child: RadioMenuButtons(),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'نمط الدفع',
                              style: FontStyleApp.blueAccent18.copyWith(
                                fontSize: getResponsiveText(context, 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFieldAndDetails(
                      hintText: 'الصندوق الرئيسي',
                      controller: TextEditingController(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                ContainerFields(
                  children: [
                    TextFieldAndDetails(
                      hintText: 'مجموع الفاتورة',
                      controller: TextEditingController(),
                    ),
                    TextFieldAndDetails(
                      hintText: 'الحسم الممنوح',
                      controller: TextEditingController(),
                    ),
                    TextFieldAndDetails(
                      hintText: 'صافي الفاتورة',
                      controller: TextEditingController(),
                    ),
                    TextFieldAndDetails(
                      hintText: 'المبلغ المقبوض',
                      controller: TextEditingController(),
                    ),
                    TextFieldAndDetails(
                      hintText: 'المبلغ المتبقي',
                      controller: TextEditingController(),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ContainerFields(
                  children: [
                    TextFieldDate(
                      date: date,
                      hoursOrYear: true,
                      label: 'التاريخ',
                    ),
                    TextFieldDate(
                      date: hour,
                      hoursOrYear: false,
                      label: 'الوقت',
                    ),
                    TextFieldAndDetails(
                      keyType: TextInputType.numberWithOptions(),
                      hintText: 'رقم الورقة',
                      controller: TextEditingController(),
                    ),
                    CommentsTextField(
                      maxLines: 4,
                      label: 'ملاحظة',
                      controller: TextEditingController(),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CustomContainer(
                  borderRadius: BorderRadius.circular(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('طباعة الفاتور أيضاً'),
                      Checkbox(value: false, onChanged: (value) {}),
                      const SizedBox(width: 15),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'حفظ وإنهاء',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 130, 128, 128),
                      fontSize: getResponsiveText(context, 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
