import 'package:post_media_social/common/widgets/circle_avatar.dart';
import 'package:post_media_social/config/export.dart';

class ItemNoti extends StatelessWidget {
  const ItemNoti({super.key, required this.result, required this.animation});
  final Map result;

  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizeTransition(
      key: ValueKey(result["image_post"]),
      sizeFactor: animation,
      child: ScaleTransition(
        scale: animation,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 140,
              minHeight: 120,
            ),
            child: SizedBox(
              width: double.maxFinite,
              height: size.height * 0.15,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: const Alignment(0, -0.5),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.error.withOpacity(0.8),
                      ),
                      child: const SizedBox(
                        width: 10,
                        height: 10.0,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatarCst(
                        urlAvatar: result["avatarUrl"],
                        radius: 50,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: result["username"],
                            style: GoogleFonts.robotoMono(
                              fontSize: 14.0,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: " liked your post and comment:",
                                style: GoogleFonts.robotoMono(
                                  fontSize: 14.0,
                                  color: AppColors.dark.withOpacity(0.3),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              TextSpan(
                                text: "\"${result["comment"]}.\"",
                                style: GoogleFonts.robotoMono(
                                  fontSize: 14.0,
                                  color: AppColors.dark.withOpacity(0.7),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          maxLines: 5,
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          '- ${result["created_at"]} ago',
                          style: GoogleFonts.robotoMono(
                            fontSize: 12.0,
                            color: AppColors.dark.withOpacity(0.6),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            result["image_post"],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const SizedBox(
                        width: 70,
                        height: 50,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
