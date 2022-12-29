//-------------------------[define name route]-------------------------------
//[Follow: login]
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'export.dart';

const String splashPath = "/splash";
const String loginPath = "/login";
const String otpPath = "$loginPath/otp";
const String registerPath = "/register";
//[Follow: home]
const String homePath = "/home";
const String uploadPostPath = "$homePath/upload-post";
const String myPostPath = "$homePath/my-post";
const String notificationPath = "$homePath/notification";

//-------------------------[define widget loading]-------------------------------

final spinkit = SpinKitFadingCircle(
  itemBuilder: (BuildContext context, int index) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primary,
      ),
    );
  },
);
