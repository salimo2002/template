import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
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
          ],
        ),
      ),
    );
  }
}
