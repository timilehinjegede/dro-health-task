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
    primaryColorLight: purpleColor,
    accentColor: purpleColor,
    primaryIconTheme: IconThemeData().copyWith(color: blackColor),
    iconTheme: IconThemeData().copyWith(color: blackColor),
    textTheme: _buildDroHealthTextTheme(baseTheme.textTheme),
  );
}

TextTheme _buildDroHealthTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline6: base.headline6.copyWith(
          fontWeight: FontWeight.w500,
        ),
        caption: base.caption.copyWith(
          color: greyColor,
          fontSize: 13,
        ),
        bodyText1: base.bodyText1.copyWith(
          fontSize: 16,
        ),
        button: base.button.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      )
      .apply(
        fontFamily: ProximaNova,
      );
}
