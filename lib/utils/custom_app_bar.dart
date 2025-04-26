import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

AppBar customAppBar({
  required BuildContext context,
  required String title,
  required bool showIcons,
}) {
  return AppBar(
    // automaticallyImplyLeading: false,
    backgroundColor: kBlueAccent,
    title: Text(
      title,
      style: FontStyleApp.white18.copyWith(
        fontSize: getResponsiveText(context, 18),
      ),
    ),
    actions:
        showIcons
            ? [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            ]
            : null,
  );
}
