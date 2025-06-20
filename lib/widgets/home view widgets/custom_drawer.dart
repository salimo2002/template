import 'package:flutter/material.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/devices_activated_view.dart.dart';
import 'package:template/views/setting_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            
            child: Image.asset('assets/img/Login/pictureBox3.Image.png'),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, SettingView.id),
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
          InkWell(
            onTap: () => Navigator.pushNamed(context, DevicesActivatedView.id),
            child: ListTile(
              trailing: Icon(Icons.key),
              title: Text(
                'الاجهزة المفعلة',
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
