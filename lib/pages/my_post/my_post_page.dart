import 'package:post_media_social/bloc/home/home_bloc.dart';
import 'package:post_media_social/common/components/item_post.dart';

import '../../config/export.dart';

class MyPostPage extends StatelessWidget {
  const MyPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'My post',
          style: GoogleFonts.roboto(
            fontSize: 22.0,
            color: AppColors.dark,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccessfulState) {
            if (state.listPost.isEmpty) {
              return _builDataEmpty();
            }
            if (state.listPost.isNotEmpty) {
              final model = state.listPost;
              final myPost = model
                  .where(
                      (element) => element.user.id == BoxUser.instance.userId)
                  .toList();
              return ListView.builder(
                itemCount: myPost.length,
                itemBuilder: (cxt, index) {
                  return ItemPost(
                    lastItem: index == myPost.length - 1,
                    postModel: myPost[index],
                    index: index,
                  );
                },
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }

  Column _builDataEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          child: SvgPicture.asset("assets/images/img-list-empty.svg"),
        ),
        const SizedBox(height: 15.0),
        Align(
          child: Text(
            'List post empty',
            style: GoogleFonts.roboto(
              fontSize: 18.0,
              color: AppColors.dark,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
}
