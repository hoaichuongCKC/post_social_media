import 'package:post_media_social/config/export.dart';

class CircleAvatarCst extends StatelessWidget {
  const CircleAvatarCst({
    super.key,
    this.radius = 50,
    this.isCameraIcon = false,
    required this.urlAvatar,
    this.isHasBorder = false,
    this.widthBorder = 5.0,
    this.onPressed,
    this.boxFit = BoxFit.cover,
  });
  final double radius;
  final bool isCameraIcon;
  final String urlAvatar;
  final bool isHasBorder;
  final VoidCallback? onPressed;
  final double widthBorder;
  final BoxFit boxFit;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isHasBorder ? EdgeInsets.all(widthBorder) : null,
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withOpacity(0.5),
      ),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
              image: DecorationImage(
                fit: boxFit,
                image: CachedNetworkImageProvider(
                  urlAvatar,
                ),
              ),
            ),
          ),
          !isCameraIcon
              ? const SizedBox()
              : Align(
                  alignment: Alignment.bottomRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.35,
                    heightFactor: 0.35,
                    child: InkWell(
                      onTap: onPressed,
                      customBorder: const CircleBorder(),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.light,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.4),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.camera_alt,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
