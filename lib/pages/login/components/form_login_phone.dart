import 'package:flutter/material.dart';
import 'package:post_media_social/config/colors.dart';
import 'package:post_media_social/config/style_text.dart';

class FormLoginPhone extends StatelessWidget {
  const FormLoginPhone(
      {super.key, required this.size, required this.controller});
  final Size size;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 30.0,
            minHeight: 20.0,
          ),
          child: SizedBox(
            width: size.width,
            height: size.height * 0.04,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                'Phone number',
                style: AppStyleText.normalStyleColor,
              ),
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "Invalid phone number.";
            }
            return null;
          },
          decoration: const InputDecoration(
            errorStyle: TextStyle(
              fontSize: 12.0,
              color: Colors.red,
            ),
            hintText: 'Enter the phone',
            hintStyle: TextStyle(
              fontSize: 12.0,
              color: AppColors.disable,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
