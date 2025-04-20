
import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/views/item_card_view.dart';
import 'package:template/views/items_classifications_view.dart';
import 'package:template/widgets/custom_container.dart';
import 'package:template/widgets/parts_titel.dart';
import 'package:template/widgets/row_custom_button.dart';

class ProductCatalog extends StatelessWidget {
  const ProductCatalog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         PartsTitle(
           title: 'المواد وتصنيفاتها',
           color: kblueAccent,
         ),
        
         SizedBox(height: 5),
         RowCustomButton(
           icon1: Icons.file_copy,
           icon2: Icons.file_copy_outlined,
           onTap1: () {},
           onTap2: () {
             Navigator.pushNamed(context,ItemCardView.id);
           },
           text2: 'بطاقات المواد',
           text1: 'فاتورة مواد أول المدة',
         ),
         SizedBox(height: 5),
         RowCustomButton(
           icon1: Icons.file_download,
           icon2: Icons.dock_sharp,
           onTap1: () {},
           onTap2: () {Navigator.pushNamed(context, ItemsClassificationsView.id);},
           text1: 'جرد المستودع',
           text2: 'تصنيفات المواد',
         ), SizedBox(height: 5),
         RowCustomButton(
           icon1: Icons.file_download,
           icon2: Icons.dock_sharp,
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
