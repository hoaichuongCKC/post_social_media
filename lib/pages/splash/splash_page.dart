import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:post_media_social/config/colors.dart';
import 'package:post_media_social/config/constants.dart';
import 'package:post_media_social/config/routes.dart';
import 'package:post_media_social/config/style_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (timer.tick == 2) {
        AppRoutes.popAndPushNamed(loginPath);
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final spinkit = SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return const DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.primary,
          ),
        );
      },
    );
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: double.infinity,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 2),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: SvgPicture.asset("assets/icons/logo.svg"),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: FractionallySizedBox(
                    heightFactor: 0.25,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "Mr.Chương Social",
                        style: AppStyleText.heading1StyleColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: spinkit,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
