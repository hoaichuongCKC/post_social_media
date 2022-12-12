import 'package:flutter/material.dart';
import 'package:post_media_social/config/colors.dart';

var swatchCustom = const MaterialColor(
  0xFF35D0B4,
  {
    50: AppColors.primary, //10%
    100: AppColors.primary, //20%
    200: AppColors.primary, //30%
    300: AppColors.primary, //40%
    400: AppColors.primary, //50%
    500: AppColors.primary, //60%
    600: AppColors.primary, //70%
    700: AppColors.primary, //80%
    800: AppColors.primary, //90%
    900: AppColors.primary, //100%
  },
);

ThemeData themeApp =
    ThemeData(primaryColor: AppColors.primary, primarySwatch: swatchCustom);
