
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/setting_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Center(child: Text('imageeeeeee Logo')),
          ),
          InkWell(onTap: () => Navigator.pushNamed(context, SettingView.id),
            child: ListTile(
              trailing: Icon(Icons.settings),
              title: Text(
                'الاعدادات',
                textAlign: TextAlign.end,
                style: FontStyleApp.blackCustom18.copyWith(
                  fontSize: getResponsiveText(context, 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}