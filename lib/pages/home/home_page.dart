// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/services.dart';
import 'package:post_media_social/bloc/home/home_bloc.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/core/pusher/pusher_app.dart';
import 'package:post_media_social/pages/home/components/bottom_nav_home.dart';
import 'package:post_media_social/pages/home/components/header_home.dart';
import 'package:post_media_social/pages/home/components/list_post.dart';
import 'package:post_media_social/pages/home/components/tab_home.dart';
import 'package:post_media_social/pages/profile/profile_page.dart';
import 'dart:io' show Platform, exit;

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;

  final int _limit = 5;

  bool _canLoadMore = true;

  late ScrollController _scrollController;

  late HomeBloc _homeBloc;

  //Declare pusher

  final String _channelName = "post";

  final AppPusher _pusherClient = AppPusher();

  ValueNotifier<int> indexPage = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    _homeBloc = BlocProvider.of<HomeBloc>(context)
      ..add(LoadPostEvent(limit: _limit, page: _page))
      ..stream.listen((state) {
        if (state is HomeSuccessfulState) {
          if (state.stateLoad is LoadDataEmtpy) {
            _canLoadMore = false;
          }
        }
      });

    _pusherClient.initPusher(
      onEvent: (PusherEvent event) {
        if (event.data.isNotEmpty) {
          _homeBloc.add(AddNewPostEvent(post: event.data));
        }
      },
      onError: (message, code, error) {},
      channelName: _channelName,
    );

    _scrollController = ScrollController()
      ..addListener(() {
        if (!_scrollController.hasClients) return;

        if (_scrollController.hasClients &&
            _scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent) {
          if (_canLoadMore) {
            _page++;
            _homeBloc.add(LoadMorePostEvent(page: _page, limit: _limit));
          }
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    indexPage.dispose();
    _pusherClient.disconnectPusher();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavHome(
        onTap: (int index) {
          indexPage.value = index;
        },
      ),
      backgroundColor: AppColors.light,
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: indexPage,
            builder: (context, int currentIndex, child) {
              return IndexedStack(
                index: currentIndex,
                children: [
                  _buildBody(),
                  const ProfilePage(),
                ],
              );
            }),
      ),
    );
  }

  Widget _buildBody() => WillPopScope(
        onWillPop: () async {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
          return true;
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) {
            if (current is HomeSuccessfulState) {
              return current.hasLoadMore == true;
            }
            return previous != current;
          },
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return Center(
                child: spinkit,
              );
            }
            if (state is HomeErrorState) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is HomeSuccessfulState) {
              return RefreshIndicator(
                edgeOffset: 0,
                strokeWidth: 1.5,
                onRefresh: () async {
                  _page = 0;

                  _homeBloc.add(OnRefreshDataEvent(page: _page, limit: _limit));
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 220,
                            minHeight: 180,
                          ),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                HeaderHome(size: MediaQuery.of(context).size),
                                const TabHome(),
                                const Divider(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const ListPostHome(),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 20.0,
                        child: null,
                      ),
                    )
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      );
}
