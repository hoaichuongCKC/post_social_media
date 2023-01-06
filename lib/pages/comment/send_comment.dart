import 'package:post_media_social/bloc/comment/comment_bloc.dart';

import '../../config/export.dart';

class SendComment extends StatefulWidget {
  const SendComment({super.key, required this.postId});
  final int postId;
  @override
  State<SendComment> createState() => _SendCommentState();
}

class _SendCommentState extends State<SendComment> {
  late CommentBloc _bloc;

  final formKey = GlobalKey<FormState>();

  final control = TextEditingController();

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<CommentBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 15.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 50.0,
          minHeight: 45.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Form(
                key: formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {}
                    return null;
                  },
                  controller: control,
                  decoration: const InputDecoration(
                    hintText: "Enter the message",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            BlocBuilder<CommentBloc, CommentState>(
              builder: (context, state) {
                if (state is CommentLoadSuccessfulState) {
                  if (state.isLoading) {
                    return spinkit;
                  }
                  return IconButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _bloc.add(CommentPostEvent(
                            postId: widget.postId, message: control.text));
                        control.text = "";
                      }
                    },
                    icon: const Icon(
                      Icons.send_rounded,
                      size: 25.0,
                      color: AppColors.primary,
                    ),
                  );
                }
                if (state is CommentDataEmptyState) {
                  return IconButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _bloc.add(CommentPostEvent(
                            postId: widget.postId, message: control.text));
                        control.text = "";
                      }
                    },
                    icon: const Icon(
                      Icons.send_rounded,
                      size: 25.0,
                      color: AppColors.primary,
                    ),
                  );
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
