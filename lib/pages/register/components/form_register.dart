import 'dart:io';

import 'package:post_media_social/bloc/register/register_bloc.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/core/camera/camera_app.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController displayNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  File? _image;

  late RegisterBloc bloc;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    bloc = BlocProvider.of<RegisterBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
    usernameController.dispose();
    displayNameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) async {
        if (state is RegisterLoadingState) {
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
        if (state is RegisterErrorState) {
          AppRoutes.pop();
          PopupControl.instance
              .showAuthError(context: context, error: state.message);
        }
        if (state is RegisterSuccessState) {
          AppRoutes.pop();
          PopupControl.instance.showAuthSuccess(context: context);
          await Future.delayed(const Duration(seconds: 2));
          AppRoutes.pushNameAndRemoveUntil(homePath);
        }
      },
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LabelTextFormField(
                  size: size,
                  controller: usernameController,
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
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
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: phoneController,
                  label: "Phone",
                  hintText: "Enter the phone",
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Invalid phone";
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
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
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
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Invalid password";
                    }
                    if (confirmPasswordController.text !=
                        passwordController.text) {
                      return "Invalid password and confirm";
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
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  label: "Confirm password",
                  hintText: "Enter the confirm password",
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Invalid confirm password";
                    }
                    if (confirmPasswordController.text !=
                        passwordController.text) {
                      return "Invalid password and confirm";
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
                    maxHeight: 25.0,
                    minHeight: 18.0,
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
                InkWell(
                  onTap: () async {
                    final result = await CameraSeviceApp().pickImage();

                    if (result != null) {
                      _image = result;
                      setState(() {});
                    }
                  },
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 150.0,
                      minHeight: 80.0,
                    ),
                    child: SizedBox(
                      height: size.height * 0.3,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: _image == null
                            ? SvgPicture.asset(
                                "assets/images/img-select-file.svg",
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(_image!),
                              ),
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
                if (formKey.currentState!.validate()) {
                  bloc.add(SubmitRegisterEvent(
                      username: usernameController.text,
                      displayName: displayNameController.text,
                      password: passwordController.text,
                      phone: phoneController.text,
                      image: _image!));
                }
              },
              width: size.width * 0.6,
              height: size.height * .07,
            ),
          ),
        ],
      ),
    );
  }
}
