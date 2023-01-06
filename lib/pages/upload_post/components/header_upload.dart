import '../../../config/export.dart';

class HeaderUploadPost extends StatelessWidget {
  const HeaderUploadPost({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<UserHive>>(
        valueListenable: Hive.box<UserHive>(BoxUser.nameBox).listenable(),
        builder: (context, box, child) {
          final boxUser = box.values.first;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: CircleAvatarCst(
                  radius: 60,
                  urlAvatar: sl.get<Api>().BASE_URL + boxUser.avatar,
                ),
              ),
              const SizedBox(width: 10.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  boxUser.displayName,
                  style: GoogleFonts.roboto(
                    fontSize: 18.0,
                    color: AppColors.dark,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          );
        });
  }
}
