import 'package:post_media_social/common/components/info_user_post.dart';
import 'package:post_media_social/models/image_post.dart';
import '../../config/export.dart';

class ItemPost extends StatelessWidget {
  const ItemPost({
    super.key,
    required this.lastItem,
    required this.postModel,
    required this.index,
  });
  final bool lastItem;
  final PostModel postModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InfoUserPost(
              height: size.height * .1,
              indexList: index,
              postModel: postModel,
            ),
          ),
          BodyPost(
            title: postModel.content,
            imagePost: postModel.image,
          ),
          BottomPost(
            size: size,
            postModel: postModel,
          ),
          lastItem
              ? const SizedBox()
              : const DecoratedBox(
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
  }
}

class BodyPost extends StatelessWidget {
  const BodyPost({
    super.key,
    required this.title,
    required this.imagePost,
  });
  final String title;
  final List<ImagePostModel> imagePost;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 14.0,
              color: AppColors.dark,
            ),
          ),
        ),
        imagePost.isEmpty
            ? const SizedBox()
            : ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300,
                  minHeight: 250,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * .3,
                  child: (imagePost.length == 1)
                      ? Hero(
                          tag: imagePost[0].link,
                          child: GestureDetector(
                            onTap: () => AppRoutes.pushNamed(imageDetailPath,
                                argument: imagePost[0].link),
                            child: CachedNetworkImage(
                              imageUrl:
                                  sl.get<Api>().BASE_URL + imagePost[0].link,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: imagePost.map(
                            (e) {
                              {
                                final index = imagePost.indexOf(e);
                                return Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              sl.get<Api>().BASE_URL + e.link,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      index == imagePost.length - 1
                                          ? const SizedBox()
                                          : const SizedBox(width: 5),
                                    ],
                                  ),
                                );
                              }
                            },
                          ).toList(),
                        ),
                ),
              )
      ],
    );
  }
}

class BottomPost extends StatefulWidget {
  const BottomPost({
    super.key,
    required this.size,
    required this.postModel,
  });

  final Size size;
  final PostModel postModel;
  @override
  State<BottomPost> createState() => _BottomPostState();
}

class _BottomPostState extends State<BottomPost> {
  late ValueNotifier<bool> isLike;

  late int totalLike;

  @override
  void initState() {
    super.initState();
    isLike = ValueNotifier(widget.postModel.likeUser);
    totalLike = widget.postModel.likeNumber;
  }

  @override
  void dispose() {
    super.dispose();
    isLike.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 80,
          minHeight: 60,
        ),
        child: SizedBox(
          width: double.infinity,
          height: widget.size.height * .1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isLike,
                        builder: (context, bool currentLike, child) {
                          if (currentLike && totalLike > 1) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.thumb_up_alt,
                                    size: 18.0, color: Colors.blue),
                                Text(
                                  ' & ${totalLike - 1} other',
                                  style: GoogleFonts.roboto(
                                    fontSize: 12.0,
                                    color: AppColors.disable,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              ],
                            );
                          }
                          if (currentLike && totalLike == 1) {
                            return const Icon(Icons.thumb_up_alt,
                                size: 18.0, color: Colors.blue);
                          }

                          return Text(
                            '$totalLike like',
                            style: GoogleFonts.roboto(
                              fontSize: 12.0,
                              color: AppColors.disable,
                              fontWeight: FontWeight.w300,
                            ),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.postModel.cmtNumber} comments',
                        style: GoogleFonts.roboto(
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
                        child: ValueListenableBuilder<bool>(
                          valueListenable: isLike,
                          builder: (context, bool currentLike, child) {
                            return InkWell(
                              onTap: () {},
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/love.svg",
                                      color: currentLike
                                          ? null
                                          : AppColors.disable,
                                    ),
                                    const SizedBox(width: 6.0),
                                    Text(
                                      "Like",
                                      style: AppStyleText.smallStyleDefault,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
                            width: widget.size.width * .005,
                            height: widget.size.height * .009,
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            showComment(widget.postModel.postId);
                          },
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset("assets/icons/comment.svg"),
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
    );
  }

  showComment(int postId) async {
    AppRoutes.pushNamed(commentPath, argument: postId);
  }
}
