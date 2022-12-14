// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:post_media_social/config/colors.dart';

class ButtonCustom extends StatelessWidget {
  ButtonCustom({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 45.0,
    required this.width,
    this.radius = 12.0,
    this.background = AppColors.primary,
  });
  final String text;
  final VoidCallback onPressed;
  final double width;
  double? height;
  double? radius;
  Color? background;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: AppColors.disable,
      borderRadius: BorderRadius.all(Radius.circular(radius!)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius!)),
          color: background,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 45.0,
            minHeight: 20.0,
            minWidth: 150.0,
          ),
          child: SizedBox(
            width: width,
            height: height,
            child: Center(
              child: FittedBox(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: AppColors.light,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
