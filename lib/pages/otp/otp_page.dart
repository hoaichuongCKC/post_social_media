import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/config/scaffold_message.dart';
import 'package:post_media_social/pages/otp/components/header_otp.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.phone});
  final String phone;
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  final formKey = GlobalKey<FormState>();

  String get phone => widget.phone;

  String _verificationId = '';
  int _resendToken = 0;
  bool _isLoading = false;
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    verifiedPhone();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  void verifiedPhone() async {
    await auth
        .verifyPhoneNumber(
          phoneNumber: '+84 $phone',
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential).then((value) {});
          },
          verificationFailed: (FirebaseAuthException exception) {
            if (exception.code == "invalid-phone-number") {
              AppSnackbar.showMessage("Error: invalid phone number");
            }

            if (exception.code == "too-many-requests") {
              AppSnackbar.showMessage(
                  "You have requested phone number verification too many times");
            }
          },
          codeSent: (String verificationId, int? resendToken) {
            _verificationId = verificationId;
            _resendToken = resendToken!;
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            debugPrint("codeAutoRetrievalTimeout ahahah");
            _verificationId = verificationId;
          },
          forceResendingToken: _resendToken,
        )
        .whenComplete(() {});
    setState(() {});
  }

  void verifyOtp(String code) async {
    _isLoading = true;
    setState(() {});
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: code,
      );
      await auth.signInWithCredential(credential).then(
        (user) {
          if (user.user != null) {
            AppRoutes.pushNameAndRemoveUntil(homePath);
          }
        },
      ).onError((error, stackTrace) {
        _isLoading = false;
        setState(() {});
        AppSnackbar.showMessage(error.toString());
      });
    } catch (e) {
      debugPrint("exception verify otp $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.light,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ArrowBackWidget(),
                    HeaderOtp(size: size),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: formKey,
                          child: PinCodeTextField(
                            autoDisposeControllers: false,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")),
                            ],
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
                              fieldOuterPadding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                            ),
                            cursorColor: AppColors.disable,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: textEditingController,
                            onSubmitted: (value) {
                              verifyOtp(value);
                            },
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v) {
                              verifyOtp(v);
                            },
                            onChanged: (value) {},
                            beforeTextPaste: (text) {
                              return true;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _isLoading
                  ? ColoredBox(
                      color: AppColors.dark.withOpacity(0.4),
                      child: SizedBox(
                        width: size.width,
                        height: size.height,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
