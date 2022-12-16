import 'package:flutter/material.dart';
import 'package:post_media_social/common/components/label_text_form_field.dart';

class FormLoginPhone extends StatelessWidget {
  const FormLoginPhone(
      {super.key, required this.size, required this.controller});
  final Size size;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return LabelTextFormField(
      size: size,
      controller: controller,
      label: "Phone number",
      hintText: 'Enter the phone',
    );
  }
}
