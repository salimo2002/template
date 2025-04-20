import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/widgets/custom_button_.dart';
import 'package:template/widgets/parts_titel.dart';

class HomeView extends StatelessWidget {
  
  const HomeView({super.key});
  static String id = 'HomeView';
  @override
  Widget build(BuildContext context) {
    List listItem=['فاتورة مبيعات جديدة','فتورة مشتريات جديدة','سند جديد','فاتورة مرتجعات جديدة'];
    List listItemIcons=[Icons.file_download_done,Icons.file_copy,Icons.file_copy_outlined,Icons.file_open];
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
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(color: kblueAccent),
                borderRadius: BorderRadius.circular(5),
                color: kWhite,
              ),
              child: Column(
                children: [
                  PartsTitle(title: 'انشاء فواتير و سندات جديد', color: kblueAccent),
                  Expanded(
                    child: GridView.builder(
                      itemCount: 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,crossAxisSpacing: 2
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 30),
                          child: CustomButton(
                            text: listItem[index],
                            icon: listItemIcons[index],
                            onTap: () {},
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
