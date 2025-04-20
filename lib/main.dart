
import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/views/home_view.dart';

void main(List<String> args) {
  runApp(Albaseet());
}

class Albaseet extends StatelessWidget {
  const Albaseet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      theme: ThemeData(
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(iconColor: WidgetStateProperty.all(kWhite)),
        ),
      ),
    );
  }
}
