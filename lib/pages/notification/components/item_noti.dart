import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/models/notification.dart';

class ItemNoti extends StatelessWidget {
  const ItemNoti(
      {super.key,
      required this.result,
      this.animation,
      required this.isCheckToday});
  final NotificationModel result;
  final bool isCheckToday;
  final Animation<double>? animation;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
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
              isCheckToday
                  ? Align(
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
                    )
                  : const SizedBox(),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatarCst(
                    urlAvatar:
                        sl.get<Api>().BASE_URL + result.avatarUserComment,
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
                        text: result.nameUserComment,
                        style: GoogleFonts.roboto(
                          fontSize: 14.0,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: " liked your post and comment:",
                            style: GoogleFonts.roboto(
                              fontSize: 14.0,
                              color: AppColors.dark.withOpacity(0.3),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: "\"${result.title}.\"",
                            style: GoogleFonts.roboto(
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
                      '- ${result.created_at.toIso8601String().getCurrentTimePost()}',
                      style: GoogleFonts.roboto(
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
                        sl.get<Api>().BASE_URL + result.post[0]["link"],
                        headers: sl.get<Api>().headers,
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
    );
  }
}
