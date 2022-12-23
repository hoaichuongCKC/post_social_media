import 'package:post_media_social/common/widgets/circle_avatar.dart';
import 'package:post_media_social/config/export.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.light,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeader(size),
          const SizedBox(height: 15.0),
          Text(
            "Microsoft",
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
                        '222',
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
                        '3',
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
          )
        ],
      ),
    );
  }

  Stack _buildHeader(Size size) {
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
              imageUrl:
                  "https://lvgames.net/lqm/wp-content/uploads/2020/10/hinh_nen_lauriel_phu_thuy_bi_ngo_download.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: size.height * .3 - 130 / 2,
          child: const CircleAvatarCst(
            isHasBorder: true,
            isCameraIcon: true,
            radius: 130,
            urlAvatar:
                'https://mondaycareer.com/wp-content/uploads/2020/11/anime-l%C3%A0-g%C3%AC-v%C3%A0-kh%C3%A1i-ni%E1%BB%87m.jpg',
          ),
        ),
      ],
    );
  }
}
