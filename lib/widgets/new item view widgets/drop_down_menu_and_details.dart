import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/category%20cubit/category_cubit.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/responsive_text.dart';

class DropDownMenuAndDetails extends StatelessWidget {
  const DropDownMenuAndDetails({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
    this.onCTap,
  });

  final int selectedIndex;
  final ValueChanged<int?> onChanged;
  final void Function(String?)? onCTap;

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
              value:
                  context
                      .read<CategoryCubit>()
                      .categories[selectedIndex]
                      .matName,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: kBlueAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kBlueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kBlueAccent),
                ),
                filled: true,
                fillColor: kWhite,
              ),
              items:
                  context.read<CategoryCubit>().categories.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.matName,
                      child: Text(e.matName),
                    );
                  }).toList(),
              onChanged: onCTap,
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
