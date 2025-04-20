import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/new_item_view.dart';

class ItemCardView extends StatelessWidget {
  const ItemCardView({super.key});
  static String id = 'ItemCardView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'بطاقة مادة',
        showIcons: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'ادخال بطاقة مادة',
        backgroundColor: kblueAccent,
        onPressed: () {
          Navigator.pushNamed(context, NewItemView.id);
        },
        child: Icon(Icons.add_circle, color: kWhite),
      ),
    );
  }
}
