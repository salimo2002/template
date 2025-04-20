import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/container_item_classifications.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/container_name_classifications.dart';

class ItemsClassificationsView extends StatelessWidget {
  const ItemsClassificationsView({super.key});
  static String id = 'ItemClassificationsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('تصنيفات المواد', style: FontStyleApp.white18),
        backgroundColor: kblueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            ContainerNameClassifications(),
            SizedBox(height: MediaQuery.sizeOf(context).height * .005),
            ContainerItemClassifications(
              nameClassificatio: 'عام',
              onTap: () {},
            ),
            SizedBox(height: 6),
            ContainerItemClassifications(
              nameClassificatio: 'فلاشة',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
