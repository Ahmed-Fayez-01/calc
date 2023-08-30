import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomStyle {
  static var textStyle = GoogleFonts.tajawal();
  static var hintTextStyle = GoogleFonts.tajawal(
      color: Colors.grey.withOpacity(0.5),
  );

  static var listStyle = GoogleFonts.tajawal(
      );

  static var defaultStyle = GoogleFonts.tajawal(
    color: Colors.black,
  );

  static var focusBorder = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 2.0),
  );

  static var focusErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.0),
  );
  static var searchBox = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.0),
  );
  static TextStyle headLine = GoogleFonts.tajawal(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static TextStyle subTitle = GoogleFonts.tajawal(
    fontSize: 15.0,
    fontWeight: FontWeight.w200,
    height: 1.1,
    color: Colors.grey,
  );
  static TextStyle appBarText = GoogleFonts.tajawal(
    fontSize: 22.0,
    fontWeight: FontWeight.w700,
  );
  static TextStyle title = GoogleFonts.tajawal(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}
