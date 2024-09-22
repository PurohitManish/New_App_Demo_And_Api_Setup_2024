import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? height;
  final TextStyle? textStyle;
  final double? letterSpacing;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextAlign? textAlign;
  final double? textScaleFactor;
  const PrimaryText({
    required this.text,
    this.color,
    this.size,
    this.height,
    this.fontWeight,
    this.textStyle,
    this.letterSpacing,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textAlign,
    this.fontStyle,
    this.textScaleFactor,

    // this.id = 6,
  });
  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
        textScaleFactor: textScaleFactor,
        style: GoogleFonts.urbanist(
            fontSize: size,
            color: color,
            fontWeight: fontWeight,
            textStyle: textStyle,
            fontStyle: fontStyle,
            height: height,
            letterSpacing: letterSpacing));
  }
}
