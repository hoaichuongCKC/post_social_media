import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_media_social/common/widgets/circle_avatar.dart';
import 'package:post_media_social/core/api/api.dart';
import 'package:post_media_social/core/hive/user_hive.dart';

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
        child: ValueListenableBuilder<Box<UserHive>>(
            valueListenable: Hive.box<UserHive>(BoxUser.nameBox).listenable(),
            builder: (context, box, child) {
              final boxUser = box.values.first;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatarCst(
                    radius: 60,
                    urlAvatar: sl.get<Api>().BASE_URL + boxUser.avatar,
                  ),
                  const SizedBox(width: 10.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      boxUser.displayName,
                      style: GoogleFonts.robotoMono(
                        fontSize: 18.0,
                        color: AppColors.dark,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
