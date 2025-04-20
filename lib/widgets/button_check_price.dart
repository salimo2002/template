import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class ButtonCheckPrice extends StatelessWidget {
  const ButtonCheckPrice({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(border: Border.all(color: kblueAccent),
        borderRadius: BorderRadius.circular(5),
        color: kWhite,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [Spacer(),
          Text(
            style: FontStyleApp.black18.copyWith(
              fontSize: getResponsiveText(context, 18),
            ),
            title,
          ),Spacer(),
          Icon(icon,color: kblueAccent,),
          SizedBox(width:5,)
          
        ],
      ),
    );
  }
}
