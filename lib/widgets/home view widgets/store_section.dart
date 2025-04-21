import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/home%20view%20widgets/button_check_price.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/home%20view%20widgets/parts_titel.dart';

class StoreSection extends StatelessWidget {
  const StoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          PartsTitle(title: 'المتجر الإلكتروني', color: kBlueAccent),
          SizedBox(height: 5),
          ButtonCheckPrice(
            title: 'المتجر الإلكتروني',
            icon: FontAwesomeIcons.store,
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
