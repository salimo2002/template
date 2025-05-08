import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/tree%20widgets/custom_text.dart';

class TreeAccountsView extends StatelessWidget {
  const TreeAccountsView({super.key});
  static String id = 'TreeAccountsView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          style: FontStyleApp.white18.copyWith(
            fontSize: getResponsiveText(context, 12),
          ),
          'شجرة الحسابات',
        ),
        actions: [
          TextButton(
            onPressed: () {
              //////////
            },
            child: Text(
              style: FontStyleApp.white18.copyWith(
                fontSize: getResponsiveText(context, 12),
              ),
              'توسيع الكل',
            ),
          ),
        ],
        backgroundColor: kBlueAccent,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: ExpansionTile(
                iconColor: Colors.transparent,
                collapsedIconColor: Colors.transparent,
                title: IconAndDividerInTree(text: 'شحرة السحابات'),
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ExpansionTile(
                      iconColor: Colors.transparent,
                      collapsedIconColor: Colors.transparent,
                      title: IconAndDividerInTree(text: "الاصول"),
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ExpansionTile(
                            iconColor: Colors.transparent,
                            collapsedIconColor: Colors.transparent,
                            title: IconAndDividerInTree(
                              text: 'الاصول الثابتة (طويلة الامدة)',
                            ),
                            children: [
                              InkWell(
                                onTapDown: (details) {
                                  final RenderBox overlay =
                                      Overlay.of(
                                            context,
                                          ).context.findRenderObject()
                                          as RenderBox;
                                  showMenu(
                                    context: context,
                                    position: RelativeRect.fromRect(
                                      details.globalPosition &
                                          const Size(60, 60),
                                      Offset.zero & overlay.size,
                                    ),
                                    items: [
                                      CheckedPopupMenuItem(
                                        child: Text('حركة الحساب'),
                                      ),
                                    ],
                                  );
                                },
                                child: ListTile(title: Text('ابنية وأرضي')),
                              ),
                              ListTile(title: Text('معدات و تجهيزات')),
                              ListTile(title: Text('أثاث و مفروشات')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconAndDividerInTree extends StatelessWidget {
  const IconAndDividerInTree({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.add, color: Colors.black),
        SizedBox(width: 10),
        Container(width: 1, height: 40, color: kBlack),
        SizedBox(width: 10),
        CustomText(text: text),
      ],
    );
  }
}
