
import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/home%20view%20widgets/button_check_price.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/home%20view%20widgets/parts_titel.dart';

class StoreSection extends StatelessWidget {
  const StoreSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          PartsTitle(title: 'المتجر الإلكتروني', color: kblueAccent),
          SizedBox(height: 5),
          ButtonCheckPrice(
            title: 'المتجر الاكتروني',
            icon: Icons.maps_home_work_rounded,
          ),  SizedBox(height: 5),
        ],
      ),
    );
  }
}