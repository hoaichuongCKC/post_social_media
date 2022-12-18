import 'package:flutter/material.dart';
import 'package:post_media_social/common/widgets/circle_avatar.dart';

import '../../../config/export.dart';

class HeaderUploadPost extends StatelessWidget {
  const HeaderUploadPost({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 100,
        minHeight: 70,
      ),
      child: SizedBox(
        width: double.infinity,
        height: size.height * .1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CircleAvatarCst(
              width: 60,
              height: 60.0,
              urlAvatar:
                  "https://mondaycareer.com/wp-content/uploads/2020/11/anime-l%C3%A0-g%C3%AC-v%C3%A0-kh%C3%A1i-ni%E1%BB%87m.jpg",
            ),
            const SizedBox(width: 10.0),
            Align(
              alignment: Alignment.center,
              child: Text(
                'TùngLakachim',
                style: GoogleFonts.robotoMono(
                  fontSize: 18.0,
                  color: AppColors.dark,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
