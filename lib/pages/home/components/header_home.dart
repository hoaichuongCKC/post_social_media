import 'package:post_media_social/config/export.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          // final NotificationService service = NotificationService();
          // service.showNotificationScheduled(
          //     CustomNotification(
          //         id: 1,
          //         title: "GOD",
          //         body: "Xin chào bạn",
          //         payload: notificationPath),
          //     const Duration(seconds: 5));
        },
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
                        final boxUser = box.values.isEmpty
                            ? []
                            : box.values.cast<UserHive>().toList();

                        if (boxUser.isNotEmpty) {
                          return Text(
                            'Hi ${boxUser[0].displayName}',
                            style: GoogleFonts.roboto(
                              fontSize: 22.0,
                              color: AppColors.dark,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'What would you like to post today?',
                      style: GoogleFonts.roboto(
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
                final boxUser = box.values.isEmpty
                    ? []
                    : box.values.cast<UserHive>().toList();

                if (boxUser.isNotEmpty) {
                  final user = UserModel(
                      avatar: boxUser[0].avatar,
                      username: boxUser[0].username,
                      imageBackground: boxUser[0].imageBackground,
                      displayName: boxUser[0].displayName);
                  return CircleAvatarCst(
                    radius: 90,
                    boxFit: BoxFit.contain,
                    // backgroundColor: AppColors.light,
                    urlAvatar: sl.get<Api>().BASE_URL + user.avatar,
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
