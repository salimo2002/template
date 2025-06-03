import 'package:flutter/material.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/widgets/invoice%20details%20view/comments_text_field.dart';
import 'package:template/widgets/invoice%20details%20view/text_field_date.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
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

  final FocusNode _focusNode3 = FocusNode();
  final TextEditingController _nameAcountController = TextEditingController();
  final TextEditingController _deteController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'سند', showIcons: false),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            ContainerFields(
              children: [
                TextFieldDate(
                  date: _deteController,
                  hoursOrYear: true,
                  label: 'التاريخ',
                ),
                Divider(),
                CustomTextField(
                  hintText: 'الحساب',
                  controller: _nameAcountController,
                  focusNode: _focusNode,
                ),
                CustomTextField(
                  hintText: 'المبلغ',
                  controller: _amountController,
                  focusNode: _focusNode2,
                ),
                CommentsTextField(
                  focusNode: _focusNode3,
                  maxLines: 4,
                  label: 'ملاحظة',
                  controller: _noteController,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
