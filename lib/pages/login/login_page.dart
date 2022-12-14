import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:post_media_social/common/widgets/button_cts.dart';
import 'package:post_media_social/config/colors.dart';
import 'package:post_media_social/config/style_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
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
                    LimitedBox(
                      maxHeight: 30,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: phoneController,
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
                            if (form.currentState!.validate()) {}
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
                        GestureDetector(
                          onTap: () {},
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 20.0,
                              minHeight: 15.0,
                              minWidth: size.height * 0.03,
                            ),
                            child: const FittedBox(
                              child: Text(
                                'Login with username && password',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                ),
              ),
            ),
          ),
        ),
      ),
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
    return SizedBox(
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
                alignment: Alignment.center,
                child: SvgPicture.asset("assets/images/img-login.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
