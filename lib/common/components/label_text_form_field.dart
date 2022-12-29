import 'package:flutter/material.dart';
import 'package:post_media_social/config/colors.dart';
import 'package:post_media_social/config/style_text.dart';

class LabelTextFormField extends StatelessWidget {
  const LabelTextFormField(
      {super.key,
      required this.size,
      required this.controller,
      required this.label,
      required this.hintText,
      this.validator,
      this.textInputType,
      this.textInputAction,
      this.onSubmitted});
  final Size size;
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 25.0,
            minHeight: 18.0,
          ),
          child: SizedBox(
            width: size.width,
            height: size.height * 0.04,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: AppStyleText.smallStyleColor,
              ),
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          style: const TextStyle(
            fontSize: 14.0,
            color: AppColors.dark,
            fontWeight: FontWeight.w300,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
