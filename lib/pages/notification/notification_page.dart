import 'package:post_media_social/bloc/notification/notification_bloc.dart';
import 'package:post_media_social/common/popup/notification/popup_noti_control.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/core/pusher/pusher_app.dart';
import 'package:post_media_social/pages/notification/components/item_noti.dart';
import 'package:post_media_social/pages/notification/components/list_today.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final GlobalKey appbarKey = GlobalKey();

  final listKeyToday = GlobalKey<SliverAnimatedListState>();

  final listKeyWeek = GlobalKey<SliverAnimatedListState>();

  final AppPusher pusher = AppPusher();

  final _channelName = "notification-post-user${BoxUser.instance.userId}";

  late ScrollController _scrollController;

  late NotificationBloc _notificationBloc;

  @override
  void initState() {
    super.initState();
    _notificationBloc = BlocProvider.of<NotificationBloc>(context);

    if (_notificationBloc.state is NotificationInitial) {
      _notificationBloc.add(LoadNoticationEvent());
    }

    _scrollController = ScrollController()
      ..addListener(() {
        if (!_scrollController.hasClients) return;

        // if (_scrollController.hasClients &&
        //     _scrollController.position.pixels < _thresholdPixel) {
        //   // Only scroll when _canLoadMore = true and _isLoading = false
        //   if (_canLoadMore && !_isLoading) {
        //     _page++;
        //     _isLoading = true;
        //     // _notificationBloc.add(LoadMorePostEvent(page: _page, limit: _limit));
        //   }
        // }
      });
    pusher.initPusher(
      onEvent: (event) {
        if (event.data.isNotEmpty) {
          _notificationBloc.add(AddNotiTodayEvent(noti: event.data));
        }
      },
      channelName: _channelName,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => PopupNotiControl.instance.dismiss(),
      child: Scaffold(
        appBar: AppBar(
          key: appbarKey,
          elevation: 0.0,
          leading: InkWell(
            onTap: () {
              PopupNotiControl.instance.dismiss();
              AppRoutes.pop();
            },
            child: const Icon(Icons.arrow_back_ios_new, size: 20.0),
          ),
          backgroundColor: AppColors.light,
          title: Text(
            "Notifications",
            style: GoogleFonts.roboto(
              fontSize: 20.0,
              color: AppColors.dark,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: AppColors.light,
        body: BlocBuilder<NotificationBloc, NotificationState>(
          buildWhen: (previous, current) {
            if (current is NotificationLoadSucessfulState) {
              if (current.isFirstBuild) return true;
            }
            if (current is NotificationLoadingState) return true;

            if (current is NotificationLoadErrorState) return true;

            if (current is NotificationDataEmptyState) return true;

            return false;
          },
          builder: (context, state) {
            if (state is NotificationLoadingState) {
              return Center(child: spinkit);
            }

            if (state is NotificationLoadErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: GoogleFonts.roboto(
                    fontSize: 16.0,
                  ),
                ),
              );
            }

            if (state is NotificationDataEmptyState) {
              return Center(
                child: Text(
                  "Hiện tại chưa có thông báo nào!",
                  style: GoogleFonts.roboto(
                    fontSize: 16.0,
                  ),
                ),
              );
            }

            if (state is NotificationLoadSucessfulState) {
              return Scrollbar(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                        sliver: SliverToBoxAdapter(
                          child: Wrap(
                            children: [
                              Text(
                                'You have ',
                                style: GoogleFonts.roboto(
                                  fontSize: 14.0,
                                  color: AppColors.dark.withOpacity(0.6),
                                ),
                              ),
                              Text(
                                '${state.listToday.length} notifications ',
                                style: GoogleFonts.roboto(
                                  fontSize: 14.0,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                'today',
                                style: GoogleFonts.roboto(
                                  fontSize: 14.0,
                                  color: AppColors.dark.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Text(
                          "Today",
                          style: GoogleFonts.roboto(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ListNotiToday(listKeyToday: listKeyToday),
                      SliverToBoxAdapter(
                        child: Text(
                          "This week",
                          style: GoogleFonts.roboto(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        sliver: SliverAnimatedList(
                          key: listKeyWeek,
                          initialItemCount: state.listWeek.length,
                          itemBuilder: (context, index, animation) {
                            final result = state.listWeek[index];
                            final keyItem = GlobalKey();
                            return InkWell(
                              onLongPress: () {
                                PopupNotiControl.instance.showDeleteItem(
                                  context,
                                  onTap: () {
                                    state.listWeek.removeAt(index);
                                    listKeyWeek.currentState!.removeItem(
                                      index,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      (context, animation) => ItemNoti(
                                        result: result,
                                        animation: animation,
                                        isCheckToday: false,
                                      ),
                                    );
                                    AppRoutes.pop();
                                  },
                                );
                              },
                              onTap: () {},
                              child: ItemNoti(
                                key: keyItem,
                                isCheckToday: false,
                                result: result,
                                animation: animation,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
