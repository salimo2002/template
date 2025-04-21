import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/container_item_classifications.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/container_name_classifications.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/custom_alert_dialog.dart';

class ItemsClassificationsView extends StatelessWidget {
  const ItemsClassificationsView({super.key});
  static String id = 'ItemClassificationsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'تصنيفات المواد',
        showIcons: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              ContainerNameClassifications(),
              SizedBox(height: MediaQuery.sizeOf(context).height * .005),
              ContainerItemClassifications(
                color: kGrey,
                nameClassificatio: 'عام',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomAlertDialog(initialValue: 'عام');
                    },
                  );
                },
              ),
              SizedBox(height: 6),
              ContainerItemClassifications(
                color: kGrey,
                nameClassificatio: 'ألبسة',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomAlertDialog(initialValue: 'ألبسة');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
