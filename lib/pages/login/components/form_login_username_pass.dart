import 'package:flutter/material.dart';
import 'package:post_media_social/common/components/label_text_form_field.dart';
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
    bool isShowPassword = true;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LabelTextFormField(
          size: size,
          controller: controllerfirst,
          label: "Username",
          hintText: "Enter the username",
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 15.0,
            minHeight: 10.0,
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 24.0,
            minHeight: 16.0,
          ),
          child: SizedBox(
            width: size.width,
            height: size.height * 0.04,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                'Password',
                style: AppStyleText.smallStyleColor,
              ),
            ),
          ),
        ),
        StatefulBuilder(builder: (context, setState) {
          return TextFormField(
            obscureText: isShowPassword,
            controller: controllersecond,
            validator: (value) {
              if (value!.isEmpty) {
                return "Invalid password.";
              }
              return null;
            },
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColors.disable,
            ),
            decoration: InputDecoration(
              errorStyle: const TextStyle(
                fontSize: 12.0,
                color: Colors.red,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  isShowPassword = !isShowPassword;
                  setState(() {});
                },
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: Icon(
                  isShowPassword ? Icons.visibility : Icons.visibility_off,
                  size: 18.0,
                  color: AppColors.primary,
                ),
              ),
              hintText: 'Enter the password',
              hintStyle: const TextStyle(
                fontSize: 12.0,
                color: AppColors.disable,
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
