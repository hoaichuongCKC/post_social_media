import 'package:post_media_social/bloc/home/home_bloc.dart';
import 'package:post_media_social/common/components/item_post.dart';
import 'package:post_media_social/config/export.dart';

class ListPostHome extends StatefulWidget {
  const ListPostHome({super.key});

  @override
  State<ListPostHome> createState() => _ListPostHomeState();
}

class _ListPostHomeState extends State<ListPostHome> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is HomeSuccessfulState
          ? current.hasFirstPost == true ||
              current.hasFirstPost == false ||
              current.stateLoad == SuccessfulMoreData()
          : false,
      builder: (context, state) {
        if (state is HomeSuccessfulState) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: state.listPost.length,
              (context, index) {
                return ItemPost(
                  lastItem: index == state.listPost.length - 1,
                  postModel: state.listPost[index],
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
