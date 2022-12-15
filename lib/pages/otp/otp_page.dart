import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:post_media_social/config/colors.dart';
import 'package:post_media_social/config/routes.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.light,
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 25.0,
                    minHeight: 18.0,
                    maxWidth: 25.0,
                    minWidth: 18.0,
                  ),
                  child: SizedBox(
                    width: size.width * .2,
                    height: size.height * .05,
                    child: InkWell(
                      onTap: () {
                        AppRoutes.pop();
                      },
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      child: const FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.arrow_back_rounded, size: 20.0),
                      ),
                    ),
                  ),
                ),
              ),
              HeaderOtp(size: size),
              Flexible(
                flex: 1,
                child: Form(
                  key: formKey,
                  child: PinCodeTextField(
                    scrollPadding: const EdgeInsets.all(0.0),
                    appContext: context,
                    backgroundColor: AppColors.light,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    textStyle: const TextStyle(
                      fontSize: 14.0,
                      color: AppColors.dark,
                      fontWeight: FontWeight.w300,
                    ),
                    cursorWidth: 1.0,
                    cursorHeight: 6.0,
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 3) {
                        return "I'm from validator";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 30,
                      fieldWidth: 30,
                      activeColor: AppColors.primary,
                      activeFillColor: Colors.white,
                      selectedFillColor: AppColors.light,
                      selectedColor: AppColors.primary,
                      inactiveColor: AppColors.primary,
                      inactiveFillColor: AppColors.light,
                      borderWidth: 1.0,
                    ),
                    cursorColor: AppColors.disable,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    // boxShadows: const [
                    //   BoxShadow(
                    //     offset: Offset(0, 1),
                    //     color: Colors.black12,
                    //     blurRadius: 10,
                    //   )
                    // ],
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                ),
              ),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderOtp extends StatelessWidget {
  const HeaderOtp({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: FractionallySizedBox(
              heightFactor: 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Flexible(
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Verified",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: AppColors.dark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "OTP code",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: AppColors.dark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "please",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: AppColors.dark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            flex: 2,
            child: SvgPicture.asset(
              "assets/images/img-otp.svg",
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
