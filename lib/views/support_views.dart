import 'package:flutter/material.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/invoice%20details%20view/text_field_date.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class SupportViews extends StatefulWidget {
  const SupportViews({super.key});
  static String id = 'SupportViews';

  @override
  State<SupportViews> createState() => _SupportViewsState();
}

class _SupportViewsState extends State<SupportViews> {
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'سند', showIcons: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          children: [
            CustomContainer(
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 10,
                  children: [
                    CustomTextField(
                      hintText: 'الحساب',
                      controller: TextEditingController(),
                      focusNode: _focusNode,
                    ),
                    CustomTextField(
                      hintText: 'المبلغ',
                      controller: TextEditingController(),
                      focusNode: _focusNode2,
                    ),
                    TextFieldDate(
                      date: TextEditingController(),
                      hoursOrYear: true,
                      label: 'التاريخ',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
