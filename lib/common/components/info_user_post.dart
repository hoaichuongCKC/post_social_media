import 'package:post_media_social/bloc/home/home_bloc.dart';
import 'package:post_media_social/config/export.dart';

class InfoUserPost extends StatelessWidget {
  const InfoUserPost({
    super.key,
    this.maxHeight = 60,
    this.minHeight = 50,
    required this.height,
    this.isComment = false,
    required this.postModel,
    required this.indexList,
  });
  final double maxHeight;
  final double minHeight;
  final double height;
  final bool isComment;
  final PostModel postModel;
  final int indexList;

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
                      key: ValueKey(postModel.user.avatar),
                      backgroundImage: CachedNetworkImageProvider(
                        sl.get<Api>().BASE_URL + postModel.user.avatar,
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
                              postModel.user.displayName,
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
                                FittedBox(
                                  child: Text(
                                    postModel.created_at
                                        .toIso8601String()
                                        .getCurrentTimePost(),
                                    style: GoogleFonts.roboto(
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
              valueListenable: Hive.box<UserHive>(BoxUser.nameBox).listenable(),
              builder: (context, box, child) {
                // final data = box.values.first;
                final boxUser = box.values.isEmpty
                    ? []
                    : box.values.cast<UserHive>().toList();

                if (boxUser.isNotEmpty) {
                  if (boxUser[0].id == postModel.user.id) {
                    if (boxUser.isNotEmpty) {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: InkWell(
                          onTap: () {
                            final homeBloc = context.read<HomeBloc>();
                            homeBloc.add(DeletePostEvent(
                                postId: postModel.postId, index: indexList));
                          },
                          radius: 30,
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset("assets/icons/trash.svg"),
                          ),
                        ),
                      );
                    }
                  }
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
