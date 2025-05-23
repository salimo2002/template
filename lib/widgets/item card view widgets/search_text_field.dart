import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/utils/constants.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required this.searchController, this.onChanged});

  final TextEditingController searchController;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:onChanged ,
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'ابحث عن مادة',
        prefixIcon: Icon(FontAwesomeIcons.search),
        floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        isDense: true,
        fillColor: kWhite,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBorderTextFieldColor),
          borderRadius: BorderRadius.circular(18),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: kBorderTextFieldColor),
          borderRadius: BorderRadius.circular(18),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kBorderTextFieldColor),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}
