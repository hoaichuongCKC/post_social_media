import 'package:post_media_social/bloc/notification/notification_bloc.dart';
import 'package:post_media_social/common/popup/notification/popup_noti_control.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/pages/notification/components/item_noti.dart';

class ListNotiToday extends StatelessWidget {
  const ListNotiToday({
    super.key,
    required this.listKeyToday,
  });

  final GlobalKey<SliverAnimatedListState> listKeyToday;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      buildWhen: (previous, current) {
        if (current is NotificationLoadSucessfulState) {
          if (!current.isFirstBuild) return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is NotificationLoadSucessfulState) {
          return SliverPadding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: state.listToday.length,
                (context, index) {
                  final result = state.listToday[index];

                  return InkWell(
                    onLongPress: () {
                      PopupNotiControl.instance.showDeleteItem(
                        context,
                        onTap: () {},
                      );
                    },
                    child: ItemNoti(
                      isCheckToday: true,
                      result: result,
                    ),
                  );
                },
              ),
              // key: listKeyToday,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
