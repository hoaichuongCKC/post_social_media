import 'package:flutter/material.dart';
import 'package:post_media_social/common/components/label_text_form_field.dart';
import 'package:post_media_social/config/export.dart';

class FormLoginPhone extends StatelessWidget {
  const FormLoginPhone(
      {super.key,
      required this.size,
      required this.controller,
      this.onSubmitted});
  final Size size;
  final TextEditingController controller;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return LabelTextFormField(
      size: size,
      controller: controller,
      label: "Phone number",
      onSubmitted: onSubmitted,
      hintText: 'Enter the phone',
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.number,
      validator: (p0) {
        if (p0!.isEmpty) {
          return "Invalid value";
        }
        if (p0.length < 9) {
          return "Length phone invalid";
        }
        return null;
      },
    );
  }
}
