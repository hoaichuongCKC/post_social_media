import 'package:post_media_social/bloc/auth/auth_bloc.dart';
import 'package:post_media_social/bloc/user/user_bloc.dart';
import 'package:post_media_social/config/export.dart';
import 'dart:io';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.light,
        body: ValueListenableBuilder<Box<UserHive>>(
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
                return BodyProfile(data: user);
              }

              return const SizedBox();
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

  late UserBloc bloc;
  late AuthBloc _authBloc;

  @override
  void initState() {
    bloc = BlocProvider.of<UserBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildHeader(
            size, getData.avatar, getData.imageBackground, getData.username),
        const SizedBox(height: 15.0),
        Text(
          getData.displayName,
          style: GoogleFonts.roboto(
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
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Likes',
                      style: GoogleFonts.roboto(
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
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Post',
                      style: GoogleFonts.roboto(
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
                        style: GoogleFonts.roboto(
                          fontSize: 14.0,
                          color: AppColors.dark,
                        ),
                      ),
                      actionsPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      actions: [
                        TextButton(
                          onPressed: () => _authBloc.add(LogoutUser()),
                          child: Text(
                            "yes",
                            style: GoogleFonts.roboto(
                              fontSize: 14.0,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => AppRoutes.pop(),
                          child: Text(
                            "No",
                            style: GoogleFonts.roboto(
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

  Widget _buildHeader(
      Size size, String urlAvatar, String urlBackground, String username) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UploadingState) {
          PopupControl.instance.showLoading(context, size);
        }
        if (state is UploadSuccessfulState) {
          AppRoutes.pop();
        }
        if (state is UploadErrorState) {
          AppRoutes.pop();
          PopupControl.instance
              .showAuthError(context: context, error: state.message);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 130 / 2),
            child: InkWell(
              onTap: () async {
                final result = await sl<CameraServiceApp>().pickImage() as File;
                final file = await sl<ImageCompressService>()
                    .compressAndGetFile(result, username);
                bloc.add(ChangeBackground(file: file));
              },
              child: SizedBox(
                width: size.width,
                height: size.height * .3,
                child: CachedNetworkImage(
                  imageUrl: urlBackground == ""
                      ? "https://lvgames.net/lqm/wp-content/uploads/2020/10/hinh_nen_lauriel_phu_thuy_bi_ngo_download.jpg"
                      : sl.get<Api>().BASE_URL + urlBackground,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Invalid url background image',
                        style: GoogleFonts.roboto(
                          fontSize: 12.0,
                          color: AppColors.error,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      const Icon(Icons.error, size: 20, color: AppColors.error),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * .3 - 130 / 2,
            child: CircleAvatarCst(
              isHasBorder: true,
              isCameraIcon: true,
              onPressed: () async {
                // get local image

                final result = await sl<CameraServiceApp>().pickImage();
                //hanlde compress file image has choose

                bloc.add(ChangeAvatar(file: result));
              },
              radius: 130,
              urlAvatar: sl.get<Api>().BASE_URL + urlAvatar,
            ),
          ),
        ],
      ),
    );
  }
}
