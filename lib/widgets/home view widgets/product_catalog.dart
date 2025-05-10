import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/utils/constants.dart';
import 'package:template/views/material_card_view.dart';
import 'package:template/views/material_classifications_view.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';
import 'package:template/widgets/home%20view%20widgets/parts_titel.dart';
import 'package:template/widgets/home%20view%20widgets/row_custom_button.dart';

class ProductCatalog extends StatelessWidget {
  const ProductCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PartsTitle(title: 'المواد وتصنيفاتها', color: kBlueAccent),

          SizedBox(height: 5),
          RowCustomButton(
            icon1: FontAwesomeIcons.fileEdit,
            icon2: FontAwesomeIcons.tags,
            onTap1: () {},
            onTap2: () {
              Navigator.pushNamed(context, MaterialCardView.id);
            },
            text2: 'بطاقات المواد',
            text1: 'فاتورة مواد أول المدة',
          ),
          SizedBox(height: 5),
          RowCustomButton(
            icon1: Icons.speed,
            icon2: FontAwesomeIcons.boxArchive,
            onTap1: () {},
            onTap2: () {
              Navigator.pushNamed(context, MaterialClassificationsView.id);
            },
            text1: 'جرد المستودع',
            text2: 'تصنيفات المواد',
          ),
          SizedBox(height: 5),
          RowCustomButton(
            icon1: FontAwesomeIcons.fileEdit,
            icon2: FontAwesomeIcons.fileEdit,
            onTap1: () {},
            onTap2: () {},
            text1: 'تعديل أسعار الشراء',
            text2: 'تعديل أسعار المبيع',
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
