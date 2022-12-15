import 'package:flutter/material.dart';
import 'package:post_media_social/config/colors.dart';
import 'package:post_media_social/config/style_text.dart';

class FormLoginUsernamePassword extends StatelessWidget {
  const FormLoginUsernamePassword(
      {super.key,
      required this.size,
      required this.controllerfirst,
      required this.controllersecond});
  final Size size;
  final TextEditingController controllerfirst;
  final TextEditingController controllersecond;
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
                'Username',
                style: AppStyleText.normalStyleColor,
              ),
            ),
          ),
        ),
        TextFormField(
          controller: controllerfirst,
          validator: (value) {
            if (value!.isEmpty) {
              return "Invalid username.";
            }
            return null;
          },
          decoration: const InputDecoration(
            errorStyle: TextStyle(
              fontSize: 12.0,
              color: Colors.red,
            ),
            hintText: 'Enter the username',
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
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 15.0,
            minHeight: 10.0,
          ),
        ),
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
                'Password',
                style: AppStyleText.normalStyleColor,
              ),
            ),
          ),
        ),
        TextFormField(
          obscureText: true,
          controller: controllersecond,
          validator: (value) {
            if (value!.isEmpty) {
              return "Invalid password.";
            }
            return null;
          },
          decoration: const InputDecoration(
            errorStyle: TextStyle(
              fontSize: 12.0,
              color: Colors.red,
            ),
            hintText: 'Enter the password',
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
