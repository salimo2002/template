import 'package:flutter/material.dart';
import 'package:template/utils/custom_app_bar.dart';

class SupportDetailsViews extends StatefulWidget {
  const SupportDetailsViews({super.key});
  static String id = 'SupportDetailsViews';
  @override
  State<SupportDetailsViews> createState() => _SupportDetailsViewsState();
}

class _SupportDetailsViewsState extends State<SupportDetailsViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'كشف حساب.',
        showIcons: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(child: Column(children: [])),
        ),
      ),
    );
  }
}
