import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/new%20item%20view%20widgets/default_unit.dart';

class RowDefaultUnit extends StatelessWidget {
  const RowDefaultUnit({
    super.key,
    required this.labels,
    required this.isSelected,
  });

  final ValueNotifier<List<String>> labels;
  final ValueNotifier<int?> isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 5),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: kWhite,
              border: Border.all(color: kBlueAccent),
            ),
            child: DefaultUnt(labels: labels, isSelected: isSelected),
          ),
        ),
        SizedBox(width: 10),
        Text(
          'الوحدة الافتراضية',
          style: FontStyleApp.blackCustom18.copyWith(
            fontSize: getResponsiveText(context, 10),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
