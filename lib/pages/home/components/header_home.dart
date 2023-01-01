import 'package:post_media_social/common/widgets/circle_avatar.dart';
import 'package:post_media_social/config/export.dart';

import '../../../core/api/api.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FractionallySizedBox(
              heightFactor: 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ValueListenableBuilder<Box<UserHive>>(
                    valueListenable:
                        Hive.box<UserHive>(BoxUser.nameBox).listenable(),
                    builder: (context, box, child) {
                      final data = box.values.first;
                      return Text(
                        'Hi ${data.displayName}',
                        style: GoogleFonts.robotoMono(
                          fontSize: 22.0,
                          color: AppColors.dark,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'What would you like to post today?',
                    style: GoogleFonts.robotoMono(
                      fontSize: 16.0,
                      color: AppColors.dark.withOpacity(0.6),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder<Box<UserHive>>(
            valueListenable: Hive.box<UserHive>(BoxUser.nameBox).listenable(),
            builder: (context, box, child) {
              final data = box.values.first;
              return CircleAvatarCst(
                radius: 90,
                boxFit: BoxFit.contain,
                // backgroundColor: AppColors.light,
                urlAvatar: sl.get<Api>().BASE_URL + data.avatar,
              );
            },
          ),
        ],
      ),
    );
  }
}
