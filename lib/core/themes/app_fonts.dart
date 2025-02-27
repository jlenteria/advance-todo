import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppFonts {
  AppFonts._();

  static TextStyle _baseStyle({
    required FontWeight fontWeight,
    required double fontSize,
    required double height,
    required int letterSpacing,
    Color? color,
  }) {
    final double finalFontSize =
        Platform.isIOS ? (fontSize - (fontSize * .2)).sp : fontSize;
    final double finalFontHeight =
        (Platform.isIOS ? (height - (height * .2)).sp : height) / finalFontSize;

    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: fontWeight,
      fontSize: finalFontSize,
      height: finalFontHeight,
      letterSpacing: 0.16 * letterSpacing,
      color: color ?? Color(0xFF17563C),
      leadingDistribution: TextLeadingDistribution.even,
      decoration: TextDecoration.none,
      decorationColor: Color(0xFF17563C),
      decorationThickness: 2.0,
    );
  }

  static TextStyle h1({
    Color? color,
    int letterSpacing = 2,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w800,
        fontSize: 24,
        height: 28,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle h2({
    Color? color,
    int letterSpacing = 2,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w800,
        fontSize: 20,
        height: 24,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle h3({
    Color? color,
    int letterSpacing = 2,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w800,
        fontSize: 18,
        height: 20,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body16B({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        height: 20,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body16SB({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 20,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body16M({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 20,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body16R({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 20,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body14B({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        height: 16,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body14SB({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        height: 16,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body14M({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 16,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body14R({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 16,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body12B({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12,
        height: 14,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body12SB({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        height: 14,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body12M({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 14,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body12R({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 14,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body10B({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w700,
        fontSize: 10,
        height: 12,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body10SB({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w600,
        fontSize: 10,
        height: 12,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body10M({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w500,
        fontSize: 10,
        height: 12,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle body10R({
    Color? color,
    int letterSpacing = 2,
    TextDecoration textDecoration = TextDecoration.none,
  }) =>
      _baseStyle(
        fontWeight: FontWeight.w400,
        fontSize: 10,
        height: 12,
        letterSpacing: letterSpacing,
        color: color,
      );
}
