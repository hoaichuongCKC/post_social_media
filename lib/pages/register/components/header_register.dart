import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:post_media_social/config/style_text.dart';

class HeaderRegister extends StatelessWidget {
  const HeaderRegister({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 150.0,
        maxHeight: 200.0,
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
                          'Create',
                          style: AppStyleText.heading1StyleWeight600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'a new',
                          style: AppStyleText.heading1StyleWeight600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'account',
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
                  child: SvgPicture.asset("assets/images/img-register.svg"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
