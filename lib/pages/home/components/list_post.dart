import 'package:post_media_social/bloc/home/home_bloc.dart';
import 'package:post_media_social/common/components/item_post.dart';
import 'package:post_media_social/config/export.dart';

class ListPostHome extends StatelessWidget {
  const ListPostHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        if (current is HomeSuccessfulState) {
          if (current.hasLoadMore == true ||
              (current.hasLoadMore == false) ||
              current.stateLoad == SuccessfulMoreData()) {
            return true;
          }
        }

        return false;
      },
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
