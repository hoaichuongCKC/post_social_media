import 'package:hive_flutter/hive_flutter.dart';
import 'package:post_media_social/bloc/auth/auth_bloc.dart';
import 'package:post_media_social/bloc/user/user_bloc.dart';
import 'package:post_media_social/common/widgets/circle_avatar.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/core/api/api.dart';
import 'package:post_media_social/core/hive/user_hive.dart';
import 'package:post_media_social/models/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.light,
        body: ValueListenableBuilder<Box<UserHive>>(
            valueListenable: Hive.box<UserHive>(BoxUser.nameBox).listenable(),
            builder: (context, box, child) {
              final boxUser = box.values.first;

              final user = UserModel(
                  avatar: boxUser.avatar,
                  imageBackground: boxUser.imageBackground,
                  displayName: boxUser.displayName);

              return BodyProfile(data: user);
            }),
      ),
    );
  }
}

class BodyProfile extends StatefulWidget {
  const BodyProfile({super.key, required this.data});
  final UserModel data;
  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  UserModel get getData => widget.data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeader(size, getData.avatar, getData.imageBackground),
        const SizedBox(height: 15.0),
        Text(
          getData.displayName,
          style: GoogleFonts.robotoMono(
            fontSize: 18.0,
            color: AppColors.dark,
            fontWeight: FontWeight.w400,
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 70,
            maxHeight: 90,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      getData.totalLikeNumber.toString(),
                      style: GoogleFonts.robotoMono(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Likes',
                      style: GoogleFonts.robotoMono(
                        fontSize: 14,
                        color: AppColors.dark,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              FractionallySizedBox(
                heightFactor: 0.5,
                child: Container(
                  width: 1.5,
                  color: AppColors.disable,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      getData.postNumber.toString(),
                      style: GoogleFonts.robotoMono(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Post',
                      style: GoogleFonts.robotoMono(
                        fontSize: 14,
                        color: AppColors.dark,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        ButtonCustom(
            text: "LogOut",
            onPressed: () {
              // ignore: prefer_function_declarations_over_variables

              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      content: Text(
                        "Do you sure logout app?",
                        style: GoogleFonts.robotoMono(
                          fontSize: 14.0,
                          color: AppColors.dark,
                        ),
                      ),
                      actionsPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      actions: [
                        TextButton(
                          onPressed: () => sl<AuthBloc>().add(LogoutUser()),
                          child: Text(
                            "yes",
                            style: GoogleFonts.robotoMono(
                              fontSize: 14.0,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => AppRoutes.pop(),
                          child: Text(
                            "No",
                            style: GoogleFonts.robotoMono(
                              fontSize: 14.0,
                              color: AppColors.dark,
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            },
            width: size.width * 0.7),
      ],
    );
  }

  Stack _buildHeader(Size size, String urlAvatar, String urlBackground) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 130 / 2),
          child: SizedBox(
            width: size.width,
            height: size.height * .3,
            child: CachedNetworkImage(
              imageUrl: urlBackground == ""
                  ? "https://lvgames.net/lqm/wp-content/uploads/2020/10/hinh_nen_lauriel_phu_thuy_bi_ngo_download.jpg"
                  : urlBackground,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Invalid url background image',
                    style: GoogleFonts.robotoMono(
                      fontSize: 12.0,
                      color: AppColors.error,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const Icon(Icons.error, size: 20, color: AppColors.error),
                ],
              ),
              filterQuality: FilterQuality.values.first,
            ),
          ),
        ),
        Positioned(
          top: size.height * .3 - 130 / 2,
          child: InkWell(
            onTap: () async {},
            child: CircleAvatarCst(
              isHasBorder: true,
              isCameraIcon: true,
              radius: 130,
              urlAvatar: sl.get<Api>().BASE_URL + urlAvatar,
            ),
          ),
        ),
      ],
    );
  }
}
