import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {

  static TextStyle montserrat(
      { Color color = Colors.black, double fontSize = 16, FontWeight fontWeight = FontWeight.normal}) {
    return GoogleFonts.montserrat(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }
}
