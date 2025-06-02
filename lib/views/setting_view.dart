import 'package:flutter/material.dart';
import 'package:template/utils/custom_app_bar.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});
   static String id='SettingView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'الإعدادات',
        showIcons: false,
      ),
    );
  }
}
