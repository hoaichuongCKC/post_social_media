import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:post_media_social/config/style_text.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                    heightFactor: 0.3,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "Mr.Chương Social",
                        style: AppStyleText.heading1StyleColor,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
