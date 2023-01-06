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
          if (current.isLoadMore == false ||
              current.stateLoad == SuccessfulMoreData()) {
            return true;
          }
        }

        return false;
      },
      builder: (context, state) {
        if (state is HomeSuccessfulState) {
          if (state.listBuild.isEmpty) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(
                  'No have posts',
                  style: GoogleFonts.roboto(
                      fontSize: 14.0, fontWeight: FontWeight.w400),
                ),
              ),
            );
          }
          return SliverList(
            key: const PageStorageKey('page-post'),
            delegate: SliverChildBuilderDelegate(
              childCount: state.listBuild.length,
              (context, index) {
                return ItemPost(
                  lastItem: index == state.listBuild.length - 1,
                  postModel: state.listBuild[index],
                  index: index,
                );
              },
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}
