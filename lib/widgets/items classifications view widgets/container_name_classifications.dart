
import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/row_name_classifications.dart';

class ContainerNameClassifications extends StatelessWidget {
  const ContainerNameClassifications({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kblueAccent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: RowNameClassifications(hintText: 'ادخل اسم التصنيف',),
    );
  }
}
