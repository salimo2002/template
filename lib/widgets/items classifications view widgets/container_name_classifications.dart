import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/row_name_classifications.dart';

class ContainerNameClassifications extends StatelessWidget {
  const ContainerNameClassifications({super.key, required this.categoryName, required this.globalKey, required this.onPressed});
 final TextEditingController categoryName;
  final GlobalKey<FormState> globalKey;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kBlueAccent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: RowNameClassifications(hintText: 'ادخل اسم التصنيف',onPressed:onPressed ,categoryName: categoryName,globalKey: globalKey,),
    );
  }
}
