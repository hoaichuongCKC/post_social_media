import 'package:post_media_social/common/components/info_user_post.dart';
import 'package:post_media_social/core/api/api.dart';
import 'package:post_media_social/models/image_post.dart';
import 'package:post_media_social/models/post.dart';
import '../../config/export.dart';

class ItemPost extends StatelessWidget {
  const ItemPost({
    super.key,
    required this.lastItem,
    required this.postModel,
  });
  final bool lastItem;
  final PostModel postModel;
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
                user: postModel.user,
                hasMyPost: postModel.hasMyPost),
          ),
          BodyPost(
            title: postModel.content,
            imagePost: postModel.image,
          ),
          BottomPost(size: size, postModel: postModel),
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
            style: GoogleFonts.robotoMono(
              fontSize: 14.0,
              color: AppColors.dark,
            ),
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
            child: CachedNetworkImage(
              imageUrl: sl.get<Api>().BASE_URL + imagePost[0].link,
              fit: BoxFit.cover,
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
    required this.postModel,
  });

  final Size size;
  final PostModel postModel;
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
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${postModel.likeNumber} likes',
                            style: GoogleFonts.robotoMono(
                              fontSize: 12.0,
                              color: AppColors.disable,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${postModel.cmtNumber} comments',
                            style: GoogleFonts.robotoMono(
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
        ],
      ),
    );
  }
}
