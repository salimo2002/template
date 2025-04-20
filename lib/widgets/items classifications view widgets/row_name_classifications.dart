
import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';

class RowNameClassifications extends StatelessWidget {
  const RowNameClassifications({
    super.key, required this.hintText,
  });
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: IconButton(onPressed: (){}, icon: Icon(Icons.add_circle),),
      ),
       SizedBox(width: MediaQuery.sizeOf(context).width*.82,height:33 ,
         child: TextField(
                     textDirection: TextDirection.rtl,
                     decoration: InputDecoration(
                       hintTextDirection: TextDirection.rtl,
                       hintText: hintText,
                       fillColor: kWhite,
                       filled: true,
                       enabledBorder: borderStyle(),
                       border: borderStyle(),
                       focusedBorder: borderStyle(),
                     ),
                   ),
       ),
    ],);
  }
}


  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(borderSide: BorderSide(color: kblueAccent));
  }