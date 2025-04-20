import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/widgets/button_check_price.dart';
import 'package:template/widgets/custom_container.dart';
import 'package:template/widgets/parts_titel.dart';
import 'package:template/widgets/row_custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = 'HomeView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('تداول', style: FontStyleApp.white18),
        backgroundColor: kblueAccent,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            spacing: 5,
            children: [
              PartsTitle(title: 'نسخة تجريبية محدودة', color: kred),
              CustomContainer(
                child: Column(
                  children: [
                    PartsTitle(title: 'المتجر الإلكتروني', color: kblueAccent),
                    SizedBox(height: 5),
                    ButtonCheckPrice(
                      title: 'المتجر الاكتروني',
                      icon: Icons.maps_home_work_rounded,
                    ),  SizedBox(height: 5),
                  ],
                ),
              ),
              CustomContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PartsTitle(
                      title: 'انشاء فواتير و سندات جديد',
                      color: kblueAccent,
                    ),
                    SizedBox(height: 5),
                    ButtonCheckPrice(
                      title: 'استعلام عن سعر مادة',
                      icon: Icons.warning_rounded,
                    ),
                    SizedBox(height: 5),
                    RowCustomButton(
                      icon1: Icons.file_copy,
                      icon2: Icons.file_copy_outlined,
                      onTap1: () {},
                      onTap2: () {},
                      text2: 'فاتورة مبيعات جديدة',
                      text1: 'فاتورة مشتريات جديدة',
                    ),
                    SizedBox(height: 5),
                    RowCustomButton(
                      icon1: Icons.file_download,
                      icon2: Icons.dock_sharp,
                      onTap1: () {},
                      onTap2: () {},
                      text1: 'فاتورة مرتجعات جديدة',
                      text2: 'سند جديد',
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
              CustomContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PartsTitle(
                      title: 'استعراض الفواتير',
                      color: kblueAccent,
                    ),
                   
                    SizedBox(height: 5),
                    RowCustomButton(
                      icon1: Icons.file_copy,
                      icon2: Icons.file_copy_outlined,
                      onTap1: () {},
                      onTap2: () {},
                      text2: 'استعراض المبيعات',
                      text1: 'استعراض المشتريات',
                    ),
                    SizedBox(height: 5),
                    RowCustomButton(
                      icon1: Icons.file_download,
                      icon2: Icons.dock_sharp,
                      onTap1: () {},
                      onTap2: () {},
                      text1: 'مرتجعات المشتريات',
                      text2: 'مرتجعات المبيعات',
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
               CustomContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PartsTitle(
                      title: 'المواد وتصنيفها',
                      color: kblueAccent,
                    ),
                   
                    SizedBox(height: 5),
                    RowCustomButton(
                      icon1: Icons.file_copy,
                      icon2: Icons.file_copy_outlined,
                      onTap1: () {},
                      onTap2: () {},
                      text2: 'بطاقات المواد',
                      text1: 'فاتورة مواد أول المدة',
                    ),
                    SizedBox(height: 5),
                    RowCustomButton(
                      icon1: Icons.file_download,
                      icon2: Icons.dock_sharp,
                      onTap1: () {},
                      onTap2: () {},
                      text1: 'جرد المستودع',
                      text2: 'تصنيفات المواد',
                    ), SizedBox(height: 5),
                    RowCustomButton(
                      icon1: Icons.file_download,
                      icon2: Icons.dock_sharp,
                      onTap1: () {},
                      onTap2: () {},
                      text1: 'تعديل أسعار الشراء',
                      text2: 'تعديل أسعار المبيع',
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
               CustomContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PartsTitle(
                      title: 'الإستعلام عن',
                      color: kblueAccent,
                    ),
                   
                    SizedBox(height: 5),
                    RowCustomButton(
                      icon1: Icons.file_copy,
                      icon2: Icons.file_copy_outlined,
                      onTap1: () {},
                      onTap2: () {},
                      text2: 'حركة مادة',
                      text1: 'حركة حساب',
                    ),
                    SizedBox(height: 5),
                    RowCustomButton(
                      icon1: Icons.file_download,
                      icon2: Icons.dock_sharp,
                      onTap1: () {},
                      onTap2: () {},
                      text1: 'حركة اليومية العامة',
                      text2: 'إجمالي حركة المواد',
                    ), SizedBox(height: 5),
                   
                  ],
                ),
              ),
                CustomContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PartsTitle(
                      title: 'الحسابات',
                      color: kblueAccent,
                    ),
                   
                    SizedBox(height: 5),
                    RowCustomButton(
                      icon1: Icons.file_copy,
                      icon2: Icons.file_copy_outlined,
                      onTap1: () {},
                      onTap2: () {},
                      text2: 'الزبائن',
                      text1: 'الموردين',
                    ),
                    SizedBox(height: 5),
                    RowCustomButton(
                      icon1: Icons.file_download,
                      icon2: Icons.dock_sharp,
                      onTap1: () {},
                      onTap2: () {},
                      text1: 'المصاريف و الإرادات',
                      text2: 'الصناديق و البنوك',
                    ), SizedBox(height: 5),
                     SizedBox(height: 5),
                    RowCustomButton(
                      icon1: Icons.file_download,
                      icon2: Icons.dock_sharp,
                      onTap1: () {},
                      onTap2: () {},
                      text1: 'شجرة الحسابات',
                      text2: 'قائمة كل الحسابات',
                    ), SizedBox(height: 5),
                   
                  ],
                ),
              ),
               CustomContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PartsTitle(
                      title: 'الديون و المستحقات',
                      color: kblueAccent,
                    ),
                   
                    SizedBox(height: 5),
                    RowCustomButton(
                      icon1: Icons.file_copy,
                      icon2: Icons.file_copy_outlined,
                      onTap1: () {},
                      onTap2: () {},
                      text2: 'الديون (لنا)',
                      text1: 'المستحقات (علينا)',
                    ),
                    SizedBox(height: 5),
                   
                  ],
                ),
              ),
              CustomContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PartsTitle(
                      title: 'التقارير المالية',
                      color: kblueAccent,
                    ),
                   
                    SizedBox(height: 5),
                    RowCustomButton(
                      icon1: Icons.file_copy,
                      icon2: Icons.file_copy_outlined,
                      onTap1: () {},
                      onTap2: () {},
                      text2: 'الأرباح و الخسائر',
                      text1: 'ملخص الحركة',
                    ),
                    SizedBox(height: 5),
                   
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
