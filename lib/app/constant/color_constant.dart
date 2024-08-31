import 'package:flutter/material.dart';

class AppColorConstant {
  static const Color appTransparent = Color(0x00000000);
  static const Color appPrimaryColor = Color(0xfffb0006);
  static const Color appBlack = Color(0xFF000000);
  static const Color appWhite = Color(0xffFFFFFF);
  static const Color appGrey = Color(0xff8E8E93);
  static const Color appWhite800 = Color(0xffF8F8F8);
  static const Color appErrorColor = Color(0xFFFB0006);

  static Color hex(String hexString) {
    var buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
