import 'package:flutter/material.dart';
import 'package:post_media_social/config/routes.dart';

class ArrowBackWidget extends StatelessWidget {
  const ArrowBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
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
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: const FittedBox(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.arrow_back_ios_new, size: 20.0),
            ),
          ),
        ),
      ),
    );
  }
}
