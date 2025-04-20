import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/widgets/button_check_price.dart';
import 'package:template/widgets/custom_button_.dart';
import 'package:template/widgets/parts_titel.dart';

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
        child: Column(
          spacing: 10,
          children: [
            PartsTitle(title: 'نسخة تجريبية محدودة', color: kred),
            PartsTitle(title: 'المتجر الإلكتروني', color: kblueAccent),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: kblueAccent),
                borderRadius: BorderRadius.circular(5),
                color: kWhite,
              ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(text: 'ssss', icon: Icons.abc, onTap: () {}),
                      SizedBox(width: 5),
                      CustomButton(text: 'ssss', icon: Icons.abc, onTap: () {}),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(text: 'ssss', icon: Icons.abc, onTap: () {}),
                      SizedBox(width: 5),
                      CustomButton(text: 'ssss', icon: Icons.abc, onTap: () {}),
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
