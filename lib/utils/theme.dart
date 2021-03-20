import 'package:dro_health/utils/utils.dart';
import 'package:flutter/material.dart';

const greyColor = Color(0xFF909090);
const darkPurpleColor = Color(0xFF7B4397);
const purpleColor = Color(0xFF9F5DE2);
const greenColor = Color(0xFF0CB8B6);
const transparentColor = Colors.transparent;
const whiteColor = Color(0xFFFFFFFF);
const blackColor = Color(0xFF000000);

ThemeData droHealthThemeData = _buildDroHealthTheme();

ThemeData _buildDroHealthTheme() {
  final baseTheme = ThemeData.light();

  return baseTheme.copyWith(
    primaryColor: purpleColor,
    buttonColor: purpleColor,
    scaffoldBackgroundColor: whiteColor,
    primaryIconTheme: IconThemeData().copyWith(color: blackColor),
    iconTheme: IconThemeData().copyWith(color: blackColor),
    textTheme: _buildDroHealthTextTheme(baseTheme.textTheme),
  );
}

TextTheme _buildDroHealthTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6.copyWith(
          fontSize: 18,
        ),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        bodyText1: base.bodyText1.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        bodyText2: base.bodyText2.copyWith(),
        subtitle1: base.subtitle1.copyWith(),
        headline4: base.headline4.copyWith(),
        button: base.button.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      )
      .apply(
        displayColor: blackColor,
        bodyColor: blackColor,
        fontFamily: ProximaNova,
      );
}
