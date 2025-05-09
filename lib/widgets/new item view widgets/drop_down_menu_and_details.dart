import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/category%20cubit/category_cubit.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/responsive_text.dart';

class DropDownMenuAndDetails extends StatelessWidget {
  const DropDownMenuAndDetails({
    super.key,
    this.onTap,
    this.onChanged,
    required this.value,
  });
  final String value;
  final void Function()? onTap;
  final void Function(String?)? onChanged;
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
              value: "محروقات",
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
                      onTap: onTap,
                      value: e.matName,
                      child: Text(e.matName),
                    );
                  }).toList(),
              onChanged: onChanged,
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
