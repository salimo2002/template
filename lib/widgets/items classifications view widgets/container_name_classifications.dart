import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/items%20classifications%20view%20widgets/row_name_classifications.dart';

class SearchByName extends StatelessWidget {
  const SearchByName({
    super.key,
    required this.categoryName,
    required this.onPressed, this.onChanged,
  });
  final TextEditingController categoryName;
  final VoidCallback onPressed;
    final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kBlueAccent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: RowNameClassifications(
        onChanged: onChanged,
        hintText: 'البحث عن تصنيف',
        onPressed: onPressed,
        categoryName: categoryName,
      ),
    );
  }
}
