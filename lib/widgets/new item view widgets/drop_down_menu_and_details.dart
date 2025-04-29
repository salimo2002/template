import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/responsive_text.dart';

class DropDownMenuAndDetails extends StatelessWidget {
  const DropDownMenuAndDetails({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 5),
        Expanded(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: DropdownButtonFormField<String>(
              value: categories[selectedIndex],
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(color: kBlueAccent)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: kBlueAccent)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: kBlueAccent)),
                filled: true,
                fillColor: kWhite,
              ),
              items: categories.map((e) {
                return DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (val) {
                final newIndex = categories.indexOf(val!);
                onChanged(newIndex);
              },
            ),
          ),
        ),
        const SizedBox(width: 20),
        Text(
          'التصنيف',
          style: TextStyle(fontSize: getResponsiveText(context, 15)),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
