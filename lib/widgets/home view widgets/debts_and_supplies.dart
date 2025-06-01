import 'package:flutter/material.dart';
import 'package:template/views/material_card_view.dart';
import 'package:template/views/material_classifications_view.dart';
import 'package:template/views/new_material_view.dart';
import 'package:template/widgets/home%20view%20widgets/custom_button_.dart';

class DebtsAndSupplies extends StatelessWidget {
  const DebtsAndSupplies({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, top: 15),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FittedBox(
            child: Row(
              spacing: 50,
              children: [
                CustomButton(
                  text: 'مادة جديدة',
                  icon: 'assets/img/home cards/medical-icon_i-billing.svg',
                  onTap: () {
                    Navigator.pushNamed(context, NewMaterialView.id);
                  },
                ),
                CustomButton(
                  text: 'دليل المواد',
                  icon: 'assets/img/home cards/hugeicons_payment-01.svg',
                  onTap: () {
                    Navigator.pushNamed(context, MaterialCardView.id);
                  },
                ),
                CustomButton(
                  text: 'تصنيفات',
                  icon: 'assets/img/home cards/medical-icon_i-billing.svg',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MaterialClassificationsView.id,
                    );
                  },
                ),
              ],
            ),
          ),
          Row(
            spacing: 50,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                text: 'حركة مادة',
                icon: 'assets/img/home cards/medical-icon_i-billing.svg',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
