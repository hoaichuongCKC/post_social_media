import 'package:post_media_social/common/components/expandable_text.dart';
import 'package:post_media_social/common/components/info_user_post.dart';
import 'package:post_media_social/config/export.dart';

class ListPostHome extends StatelessWidget {
  const ListPostHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAnimatedList(
      initialItemCount: 2,
      itemBuilder: (BuildContext ctx, int index, Animation<double> animation) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: InfoUserPost(
                  height: size.height * .1,
                ),
              ),
              const BodyPost(),
              BottomPost(size: size),
              const DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.disable,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 20.0,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class BodyPost extends StatelessWidget {
  const BodyPost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: ExpandableText(
            'Hello mọi người. \n Hôm nay thật là một ngày tuyệt vời',
            trimLines: 2,
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 300,
            minHeight: 250,
          ),
          child: SizedBox(
            width: double.infinity,
            height: size.height * .3,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(7.0)),
              child: CachedNetworkImage(
                imageUrl:
                    "https://blog.twitch.tv/assets/uploads/aa866afa180280df8b59e31ba1d14489.jpeg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BottomPost extends StatelessWidget {
  const BottomPost({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 80,
              minHeight: 60,
            ),
            child: SizedBox(
              width: double.infinity,
              height: size.height * .1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '18 likes',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: AppColors.disable,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '3 comments',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: AppColors.disable,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: FractionallySizedBox(
                      heightFactor: 1.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset("assets/icons/love.svg"),
                                    const SizedBox(width: 6.0),
                                    Text(
                                      "Like",
                                      style: AppStyleText.smallStyleDefault,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 1.5,
                              minWidth: 1.0,
                              maxHeight: 7.0,
                              minHeight: 4.0,
                            ),
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                color: AppColors.disable,
                              ),
                              child: SizedBox(
                                width: size.width * .005,
                                height: size.height * .009,
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                        "assets/icons/comment.svg"),
                                    const SizedBox(width: 6.0),
                                    Text(
                                      "Comment",
                                      style: AppStyleText.smallStyleDefault,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
          const Text(
            'Comment list post',
            style: TextStyle(
              fontSize: 16.0,
              color: AppColors.dark,
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InfoUserPost(
                  height: size.height * .07,
                  maxHeight: 30,
                  minHeight: 20,
                  isComment: true,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: ExpandableText('😄 😄 😄 😄 😄'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
