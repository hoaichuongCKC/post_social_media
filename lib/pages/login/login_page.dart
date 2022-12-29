// ignore_for_file: use_build_context_synchronously

import 'package:post_media_social/bloc/auth/auth_bloc.dart';
import 'package:post_media_social/pages/login/components/form_login_phone.dart';
import 'package:post_media_social/pages/login/components/form_login_username_pass.dart';

import '../../config/export.dart';

enum LoginType { phone, usernameAndPassword }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: const Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: BodyLogin(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BodyLogin extends StatefulWidget {
  const BodyLogin({
    super.key,
  });

  @override
  State<BodyLogin> createState() => _BodyLoginState();
}

class _BodyLoginState extends State<BodyLogin> {
  final TextEditingController xController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  ValueNotifier<LoginType> loginType = ValueNotifier(LoginType.phone);

  late AuthBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    xController.dispose();
    passwordController.dispose();
    loginType.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthLoadingState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
              content: SizedBox(
                width: size.width * 0.5,
                height: 50,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(child: spinkit),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is AuthErrorState) {
          AppRoutes.pop();
          PopupControl.instance
              .showAuthError(context: context, error: state.message);
        }
        if (state is AuthSuccessState) {
          AppRoutes.pop();
          PopupControl.instance.showAuthSuccess(context: context);
          await Future.delayed(const Duration(seconds: 2));
          AppRoutes.pushNameAndRemoveUntil(homePath);
        }
      },
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
                          onSubmitted: (p0) {
                            if (form.currentState!.validate()) {
                              AppRoutes.pushNamed(otpPath, argument: p0);
                            }
                          },
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
                  if (loginType.value == LoginType.usernameAndPassword) {
                    bloc.add(SubmitEvent(
                        username: xController.text.trim(),
                        password: passwordController.text.trim()));
                  }
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
              child: SizedBox(height: size.height * .07),
            ),
            FooterLogin(
              loginType: loginType,
              size: size,
              controllersecond: passwordController,
              controllerfirst: xController,
            ),
            const SizedBox(height: 20.0),
          ],
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
        ValueListenableBuilder<LoginType>(
          valueListenable: loginType,
          builder: (context, LoginType currentType, child) {
            String text = "Login with username && password";
            if (currentType == LoginType.usernameAndPassword) {
              text = "Login with phone number";
            }
            return TextButton(
              onPressed: () {
                if (loginType.value == LoginType.phone) {
                  loginType.value = LoginType.usernameAndPassword;
                } else {
                  loginType.value = LoginType.phone;
                }
                controllerfirst.text = "chuog123";
                controllersecond.text = "withlove";
              },
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
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 40.0,
            minHeight: 15.0,
          ),
          child: SizedBox(height: size.height * .03),
        ),
        Align(
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'New user?',
                style: TextStyle(
                  fontSize: 14.0,
                  color: AppColors.disable,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () => AppRoutes.pushNamed(registerPath),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
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
