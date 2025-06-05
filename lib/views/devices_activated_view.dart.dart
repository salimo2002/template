import 'package:flutter/material.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/widgets/log%20in%20view/mobile_activated_card.dart';

class DevicesActivatedView extends StatelessWidget {
  const DevicesActivatedView({super.key});
  static String id = 'DevicesActivatedView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'الاجهزة المفعلة',
        showIcons: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return MobileActivatedCard(
                  comName: 'اسم الشركة',
                  imei: 'IMEI $index',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
