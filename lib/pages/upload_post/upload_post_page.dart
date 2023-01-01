import 'package:post_media_social/bloc/upload/upload_post_bloc.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/pages/upload_post/components/body_upload_post.dart';

class UploadPostPage extends StatelessWidget {
  const UploadPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => sl<UploadPostBloc>(),
        child: const BodyUploadPost(),
      ),
    );
  }
}
