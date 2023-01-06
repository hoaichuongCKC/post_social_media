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
const String imageDetailPath = "$homePath/image-detail";
const String uploadPostPath = "$homePath/upload-post";
const String myPostPath = "$homePath/my-post";
const String notificationPath = "$homePath/notification";
const String commentPath = "$homePath/comment";

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

//-------------------------[define status code api]-------------------------------

const String unauthorized = "UNAUTHORIZEd";
const String badRequest = "BAD REQUEST";
const String serverError = "SERVER ERROR";
