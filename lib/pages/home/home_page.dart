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
  ValueNotifier<int> indexChanged = ValueNotifier<int>(0);
  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => sl<HomeBloc>(),
      child: Scaffold(
        bottomNavigationBar: BottomNavHome(
          onTap: (int index) {
            indexChanged.value = index;
          },
        ),
        backgroundColor: AppColors.light,
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: indexChanged,
            builder: (context, int currentIndex, child) {
              return IndexedStack(
                index: currentIndex,
                children: [
                  BodyHome(size: size),
                  const ProfilePage(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class BodyHome extends StatefulWidget {
  const BodyHome({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  int _page = 0;

  final int _limit = 10;

  late ScrollController _scrollController;

  late HomeBloc _homeBloc;

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  //Declare pusher

  final String _channelName = "post";

  final AppPusher _pusherClient = AppPusher();

  @override
  void initState() {
    super.initState();

    _homeBloc = BlocProvider.of<HomeBloc>(context);

    _homeBloc.stream.listen((state) {
      if (state is HomeSuccessfulState) {
        if (state.stateLoad is LoadDataEmtpy) {
          //chặn add eventn load more
        }
      }
    });

    _scrollController = ScrollController()
      ..addListener(() {
        // if (_scrollController.offset ==
        //     _scrollController.position.maxScrollExtent) {
        //   if (_isHasData) {
        //     ++_page;
        //     _homeBloc.add(LoadMorePostEvent(limit: _limit, page: _page));
        //     _isLoading.value = true;
        //   }
        // }
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _homeBloc.add(LoadPostEvent(limit: _limit, page: _page));
    _pusherClient.initPusher(
        onEvent: (PusherEvent event) {
          if (event.data != null) {
            _homeBloc.add(AddNewPostEvent(post: event.data));
          }
        },
        onError: (message, code, error) {
          print("message from pusher $message");
          print("code from pusher $code");
          print("error from pusher $error");
        },
        channelName: _channelName);
  }

  @override
  void dispose() {
    super.dispose();
    _pusherClient.disconnectPusher();
    _homeBloc.close();
    _isLoading.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
            return current.hasFirstPost == true;
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
                          height: widget.size.height * 0.2,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              HeaderHome(size: widget.size),
                              const TabHome(),
                              const Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const ListPostHome(),
                  SliverToBoxAdapter(
                    child: ValueListenableBuilder<bool>(
                        valueListenable: _isLoading,
                        builder: (context, bool currentLoading, child) {
                          if (currentLoading) {
                            return Center(
                              child: spinkit,
                            );
                          }
                          return const SizedBox(
                            height: 20.0,
                            child: null,
                          );
                        }),
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
}
