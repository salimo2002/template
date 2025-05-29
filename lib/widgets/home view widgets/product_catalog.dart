import 'package:flutter/material.dart';
import 'package:template/views/material_card_view.dart';
import 'package:template/widgets/home%20view%20widgets/custom_button_.dart';

class ProductCatalog extends StatelessWidget {
  const ProductCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          FittedBox(
            child: Row(
              spacing: 50,
              children: [
                CustomButton(
                  text: 'بطاقات المواد',
                  icon: 'assets/img/home cards/medical-icon_i-billing.svg',
                  onTap: () {
                    Navigator.pushNamed(context, MaterialCardView.id);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
