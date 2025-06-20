import 'package:flutter/material.dart';
import 'package:template/utils/device_type.dart';

const kBlack = Colors.black;
const kBlacCustomk = Color.fromARGB(130, 0, 0, 0);
const kWhite = Colors.white;
const kGreen = Colors.green;
const kBlueAccent = Color.fromARGB(255, 17, 116, 197);
const kRed = Color(0xffc00000);
const kGrey = Color(0xfff3f3f3);

const kGreyText = Color.fromARGB(255, 146, 146, 146);
const kLogo = 'assets/images/loogo.png';
const kColorBorder = Color(0xfff6f6f8);
const kBorderTextFieldColor = Color.fromARGB(255, 233, 228, 228);
const kBackGroundColor = Color(0xfff6f6f8);
const kSecondColor = Color(0xff4095cc);
String mainUser = '';
BoxShadow bosShadow() {
  return BoxShadow(
    offset: Offset(0, .5),
    spreadRadius: .1,
    blurRadius: 3,
    color: Colors.grey,
  );
}

late String imei;
void insertImei() async {
  imei = (await DeviceType.getDeviceImei())!;
}
// String decodeToUtf8(String brokenText) {
//     final latin1Bytes = latin1.encode(brokenText);
//     return utf8.decode(latin1Bytes);
//   }