import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/responsive_text.dart';

class DropDownMenuAndDetails extends StatelessWidget {
  const DropDownMenuAndDetails({super.key, required this.categories});
  final List<String> categories;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 5),
        Expanded(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: DropdownMenu(
              trailingIcon: SizedBox.shrink(),
              inputDecorationTheme: InputDecorationTheme(
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
              width: MediaQuery.sizeOf(context).width * .75,
              menuStyle: MenuStyle(
                maximumSize: WidgetStatePropertyAll(
                  Size(MediaQuery.sizeOf(context).width * .75, 200),
                ),
                backgroundColor: WidgetStateProperty.all(kWhite),
              ),
              dropdownMenuEntries:
                  categories.map<DropdownMenuEntry<String>>((e) {
                    return DropdownMenuEntry<String>(label: e, value: e);
                  }).toList(),
            ),
          ),
        ),
        SizedBox(width: 20),
        Text(
          ' التصنيف',
          style: TextStyle(fontSize: getResponsiveText(context, 15)),
        ),
        SizedBox(width: 20),
      ],
    );
  }
}
