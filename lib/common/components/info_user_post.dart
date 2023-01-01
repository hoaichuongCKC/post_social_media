import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/core/api/api.dart';
import 'package:post_media_social/models/user.dart';

class InfoUserPost extends StatelessWidget {
  const InfoUserPost({
    super.key,
    this.maxHeight = 60,
    this.minHeight = 50,
    required this.height,
    this.isComment = false,
    required this.user,
  });
  final double maxHeight;
  final double minHeight;
  final double height;
  final bool isComment;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        minHeight: minHeight,
      ),
      child: SizedBox(
        width: size.width,
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        sl.get<Api>().BASE_URL + user.avatar,
                      ),
                      backgroundColor: Colors.transparent,
                      radius: isComment ? 20 : 30.0,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          flex: 1,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              user.displayName,
                              style: AppStyleText.smallStyleDefault,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset("assets/icons/stopwatch.svg"),
                                const FittedBox(
                                  child: Text(
                                    '1m',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.disable,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ValueListenableBuilder<Box<UserHive>>(
                valueListenable:
                    Hive.box<UserHive>(BoxUser.nameBox).listenable(),
                builder: (context, box, child) {
                  final data = box.values.first;

                  return Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset("assets/icons/trash.svg"),
                  );
                })
          ],
        ),
      ),
    );
  }
}
