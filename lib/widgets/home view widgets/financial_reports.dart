import 'package:flutter/material.dart';
import 'package:template/views/material_card_view.dart';
import 'package:template/views/material_classifications_view.dart';
import 'package:template/views/movement_of_matter_view.dart';
import 'package:template/widgets/home%20view%20widgets/custom_button_.dart';

class FinancialReports extends StatelessWidget {
  const FinancialReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          
          Row(
            spacing: 50,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               CustomButton(
                  text: 'دليل المواد',
                  icon: 'assets/img/Home/guide-svgrepo-com.svg',
                  onTap: () {
                    Navigator.pushNamed(context, MaterialCardView.id);
                  },
                ),
                CustomButton(
                  text: 'تصنيفات',
                  icon:
                      'assets/img/Home/tags-category-categories-labels-svgrepo-com.svg',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MaterialClassificationsView.id,
                    );
                  },
                ),
                CustomButton(
                  text: 'حركة مادة',
                  icon:
                      'assets/img/Home/tags-category-categories-labels-svgrepo-com.svg',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MovementOfMatterView.id,
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
