import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/views/home_view.dart';
import 'package:template/views/material_card_view.dart';

void main(List<String> args) {
  runApp(Template());
}

class Template extends StatelessWidget {
  const Template({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(iconColor: WidgetStateProperty.all(kWhite)),
        ),
      ),
      routes: {
        HomeView.id: (context) => HomeView(),
        MaterialCardView.id: (context) => MaterialCardView(),
      },
      initialRoute: HomeView.id,
    );
  }
}
