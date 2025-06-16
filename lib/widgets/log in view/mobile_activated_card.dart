import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';

class MobileActivatedCard extends StatelessWidget {
  const MobileActivatedCard({
    super.key,
    required this.userName,
    required this.imei, required this.onPressed,
  });
  final String userName;
  final String imei;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kBlueAccent),
      ),
      child: ListTile(
        trailing: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.delete, color: kRed),
        ),
        leading: Icon(Icons.mobile_friendly),
        subtitle: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              imei,
              style: FontStyleApp.blueAccent18.copyWith(
                fontSize: getResponsiveText(context, 18),
              ),
            ),
          ),
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              userName,
              style: FontStyleApp.blueAccent18.copyWith(
                fontSize: getResponsiveText(context, 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
