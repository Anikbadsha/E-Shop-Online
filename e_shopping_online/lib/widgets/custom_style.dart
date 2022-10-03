import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

myStyle(
    [double? size,
    double? height,
    double? letterspacing,
    Color? color,
    FontWeight? fw,
    Color? bgColor]) {
  return GoogleFonts.nunito(
    fontSize: size,
    color: color,
    fontWeight: fw,
  );
}
