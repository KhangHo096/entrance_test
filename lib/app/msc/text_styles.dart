import 'package:entrance_test/app/msc/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

TextStyle get textTitle => TextStyle(fontSize: 22.dp);

TextStyle get text12 => TextStyle(fontSize: 12.dp);

TextStyle get text14 => TextStyle(fontSize: 14.dp);

TextStyle get text16 => TextStyle(fontSize: 16.dp);

extension TextStyleExt on TextStyle {
  TextStyle get black => copyWith(color: Colors.black);

  TextStyle get white => copyWith(color: Colors.white);

  TextStyle get whiteTrans50 => copyWith(color: colorWhiteTrans50);

  TextStyle get mainColor => copyWith(color: colorMain);
}
