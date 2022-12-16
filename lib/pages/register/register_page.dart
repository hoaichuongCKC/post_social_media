import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:post_media_social/common/components/label_text_form_field.dart';
import 'package:post_media_social/common/popup/popup_control.dart';
import 'package:post_media_social/common/widgets/arrow_back.dart';
import 'package:post_media_social/common/widgets/button_cts.dart';
import 'package:post_media_social/config/style_text.dart';
import 'package:post_media_social/pages/register/components/header_register.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ArrowBackWidget(),
              HeaderRegister(size: size),
              Form(
                key: formKey,
                onWillPop: () async {
                  return false;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LabelTextFormField(
                      size: size,
                      controller: usernameController,
                      label: "Username",
                      hintText: "Enter the username",
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Invalid username";
                        }
                        return null;
                      },
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 15.0,
                        minHeight: 8.0,
                      ),
                      child: const SizedBox(
                        height: 15.0,
                      ),
                    ),
                    LabelTextFormField(
                      size: size,
                      controller: displayNameController,
                      label: "Display name",
                      hintText: "Enter the display name",
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Invalid display name";
                        }
                        return null;
                      },
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 15.0,
                        minHeight: 8.0,
                      ),
                      child: const SizedBox(
                        height: 15.0,
                      ),
                    ),
                    LabelTextFormField(
                      size: size,
                      controller: passwordController,
                      label: "Password",
                      hintText: "Enter the password",
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Invalid password";
                        }
                        return null;
                      },
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 15.0,
                        minHeight: 8.0,
                      ),
                      child: const SizedBox(
                        height: 15.0,
                      ),
                    ),
                    LabelTextFormField(
                      size: size,
                      controller: confirmPasswordController,
                      label: "Confirm password",
                      hintText: "Enter the confirm password",
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Invalid confirm password";
                        }
                        return null;
                      },
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 15.0,
                        minHeight: 8.0,
                      ),
                      child: const SizedBox(
                        height: 15.0,
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
                            "Avatar",
                            style: AppStyleText.normalStyleColor,
                          ),
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 150.0,
                        minHeight: 80.0,
                      ),
                      child: SizedBox(
                        height: size.height * 0.3,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            "assets/images/img-select-file.svg",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 15.0,
                  minHeight: 8.0,
                ),
                child: const SizedBox(
                  height: 15.0,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ButtonCustom(
                  text: "Register",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                    PopupControl.instance.showAuthError(context: context);
                  },
                  width: size.width * 0.6,
                  height: size.height * .07,
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
