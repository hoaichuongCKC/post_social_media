import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_media_social/config/colors.dart';

class AppStyleText {
  // [type font size 22.0]
  static TextStyle heading1StyleWeight600 = GoogleFonts.robotoMono(
    fontSize: 22.0,
    color: AppColors.dark,
    fontWeight: FontWeight.w600,
  );

  static TextStyle heading1StyleColor = GoogleFonts.robotoMono(
    fontSize: 22.0,
    color: AppColors.primary,
    fontWeight: FontWeight.w500,
  );
  // [type font size 18.0]
  static TextStyle bigStyleDefault = GoogleFonts.robotoMono(
    fontSize: 18.0,
    color: AppColors.dark,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bigStyleColor = GoogleFonts.robotoMono(
    fontSize: 18.0,
    color: AppColors.primary,
    fontWeight: FontWeight.w600,
  );

  // [type font size 16.0]
  static TextStyle normalStyleDefault = GoogleFonts.robotoMono(
    fontSize: 16.0,
    color: AppColors.dark,
    fontWeight: FontWeight.w400,
  );

  static TextStyle normalStyleColor = GoogleFonts.robotoMono(
    fontSize: 16.0,
    color: AppColors.primary,
    fontWeight: FontWeight.w400,
  );

  // [type font size 14.0]
  static TextStyle smallStyleDefault = GoogleFonts.robotoMono(
    fontSize: 14.0,
    color: AppColors.dark,
    fontWeight: FontWeight.w400,
  );

  static TextStyle smallStyleColor = GoogleFonts.robotoMono(
    fontSize: 14.0,
    color: AppColors.primary,
    fontWeight: FontWeight.w400,
  );
}
