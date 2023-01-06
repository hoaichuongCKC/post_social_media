import 'dart:convert';

import 'package:post_media_social/bloc/comment/comment_bloc.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/core/pusher/pusher_app.dart';
import 'package:post_media_social/models/comment_post.dart';
import 'package:post_media_social/pages/comment/send_comment.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.postId});
  final int postId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late CommentBloc _bloc;

  late ScrollController _scrollController;

  final AppPusher pusher = AppPusher();

  late String _channelName;

  @override
  void initState() {
    super.initState();
    _channelName = "cmt-post${widget.postId}";

    _bloc = BlocProvider.of<CommentBloc>(context)
      ..add(LoadCommentEvent(postId: widget.postId));

    _scrollController = ScrollController()..addListener(() {});

    pusher.initPusher(
        onEvent: (event) {
          if (event.data.isNotEmpty) {
            final result =
                CommentModel.fromJson(jsonDecode(event.data)["data"]);

            _bloc.add(AddCommentEvent(commentModel: result));
            _scrollController.animateTo(0.0,
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeIn);
          }
        },
        channelName: _channelName);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    pusher.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Comment post",
          style: GoogleFonts.roboto(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: BlocBuilder<CommentBloc, CommentState>(
            buildWhen: (previous, current) {
              return previous != current;
            },
            builder: (context, state) {
              if (state is CommentLoadingState) {
                return Center(child: spinkit);
              }
              if (state is CommentErorfulState) {
                return Center(
                  child: Text(
                    state.message,
                    style: GoogleFonts.robotoMono(
                        fontSize: 16.0, color: AppColors.disable),
                  ),
                );
              }
              if (state is CommentLoadSuccessfulState) {
                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: BlocBuilder<CommentBloc, CommentState>(
                          builder: (context, state) {
                            if (state is CommentLoadSuccessfulState) {
                              return _buildList(state);
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      SendComment(postId: widget.postId),
                    ],
                  ),
                );
              }
              if (state is CommentDataEmptyState) {
                return Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'No have comment',
                          style: GoogleFonts.robotoMono(
                              fontSize: 16.0, color: AppColors.disable),
                        ),
                      ),
                    ),
                    SendComment(postId: widget.postId),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  ListView _buildList(CommentLoadSuccessfulState state) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(5.0),
      itemCount: state.list.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatarCst(
                  radius: 35.0,
                  urlAvatar:
                      sl.get<Api>().BASE_URL + state.list[index].user.avatar),
              title: Text(
                state.list[index].user.displayName,
                style: GoogleFonts.roboto(
                  fontSize: 14.0,
                ),
              ),
              subtitle: Text(
                state.list[index].created_at
                    .toIso8601String()
                    .getCurrentTimePost(),
                style: GoogleFonts.roboto(
                    fontSize: 12.0, color: AppColors.disable),
              ),
            ),
            Text(
              state.list[index].message,
              style: GoogleFonts.roboto(fontSize: 12.0, color: AppColors.dark),
            ),
          ],
        );
      },
    );
  }
}
