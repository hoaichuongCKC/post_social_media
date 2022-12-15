import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:post_media_social/common/widgets/button_cts.dart';
import 'package:post_media_social/config/colors.dart';
import 'package:post_media_social/config/routes.dart';
import 'package:post_media_social/config/style_text.dart';
import 'package:post_media_social/pages/login/components/form_login_phone.dart';
import 'package:post_media_social/pages/login/components/form_login_username_pass.dart';

enum LoginType { phone, usernameAndPassword }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController xController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  ValueNotifier<LoginType> loginType = ValueNotifier(LoginType.phone);
  @override
  void dispose() {
    super.dispose();
    xController.dispose();
    passwordController.dispose();
    loginType.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeaderLogin(size: size),
                    ValueListenableBuilder<LoginType>(
                      valueListenable: loginType,
                      builder: (context, LoginType currentType, child) {
                        return AnimatedSwitcher(
                          switchInCurve: Curves.easeIn,
                          duration: const Duration(milliseconds: 450),
                          reverseDuration: const Duration(milliseconds: 450),
                          child: currentType == LoginType.phone
                              ? FormLoginPhone(
                                  key: const ValueKey('form-phone'),
                                  controller: xController,
                                  size: size,
                                )
                              : FormLoginUsernamePassword(
                                  key: const ValueKey('form-usernamePassword'),
                                  size: size,
                                  controllerfirst: xController,
                                  controllersecond: passwordController,
                                ),
                        );
                      },
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 50.0,
                        minHeight: 15.0,
                      ),
                      child: SizedBox(height: size.height * .08),
                    ),
                    ButtonCustom(
                      text: "Log in",
                      onPressed: () {
                        if (form.currentState!.validate()) {
                          AppRoutes.pushNamed("/login/otp");
                        }
                      },
                      width: size.width * 0.6,
                      height: size.height * .06,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 40.0,
                        minHeight: 15.0,
                      ),
                      child: SizedBox(height: size.height * .08),
                    ),
                    FooterLogin(
                      loginType: loginType,
                      size: size,
                      controllersecond: xController,
                      controllerfirst: passwordController,
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FooterLogin extends StatelessWidget {
  const FooterLogin({
    super.key,
    required this.loginType,
    required this.size,
    required this.controllerfirst,
    required this.controllersecond,
  });

  final ValueNotifier<LoginType> loginType;
  final Size size;
  final TextEditingController controllerfirst;
  final TextEditingController controllersecond;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (loginType.value == LoginType.phone) {
              loginType.value = LoginType.usernameAndPassword;
            } else {
              loginType.value = LoginType.phone;
            }
            controllerfirst.text = "";
            controllersecond.text = "";
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 20.0,
              minHeight: 15.0,
              minWidth: size.height * 0.03,
            ),
            child: ValueListenableBuilder<LoginType>(
              valueListenable: loginType,
              builder: (context, LoginType currentType, child) {
                String text = "Login with username && password";
                if (currentType == LoginType.usernameAndPassword) {
                  text = "Login with phone number";
                }
                return FittedBox(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 30.0,
            minHeight: 15.0,
          ),
          child: SizedBox(height: size.height * .08),
        ),
        Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 20.0,
              minHeight: 15.0,
              minWidth: size.height * 0.03,
            ),
            child: FittedBox(
              fit: BoxFit.cover,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FittedBox(
                    child: Text(
                      'New user?',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.disable,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FittedBox(
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HeaderLogin extends StatelessWidget {
  const HeaderLogin({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 150.0,
      ),
      child: SizedBox(
        height: size.height * 0.35,
        width: size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                heightFactor: 0.5,
                widthFactor: 1.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Already',
                          style: AppStyleText.heading1StyleWeight600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'have an',
                          style: AppStyleText.heading1StyleWeight600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'account?',
                          style: AppStyleText.heading1StyleWeight600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              flex: 2,
              child: FractionallySizedBox(
                heightFactor: 0.9,
                widthFactor: 1.0,
                child: FittedBox(
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  child: SvgPicture.asset("assets/images/img-login.svg"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
