// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/services.dart';
import 'package:post_media_social/bloc/auth/auth_bloc.dart';
import 'package:post_media_social/bloc/comment/comment_bloc.dart';
import 'package:post_media_social/bloc/home/home_bloc.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/config/scaffold_message.dart';
import 'package:post_media_social/core/pusher/pusher_app.dart';
import 'package:post_media_social/pages/home/components/bottom_nav_home.dart';
import 'package:post_media_social/pages/home/components/header_home.dart';
import 'package:post_media_social/pages/home/components/list_post.dart';
import 'package:post_media_social/pages/home/components/tab_home.dart';
import 'package:post_media_social/pages/profile/profile_page.dart';
import 'dart:io' show Platform, exit;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;

  final int _limit = 5;

  final double _thresholdPixel = 100.0;

  bool _canLoadMore = true;

  bool _isLoading = false;

  late ScrollController _scrollController;

  late HomeBloc _homeBloc;

  final String _channelName = "post";

  final AppPusher _pusherClient = AppPusher();

  ValueNotifier<int> indexPage = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context)
      ..add(LoadPostEvent())
      ..stream.listen((state) {
        if (state is HomeSuccessfulState) {
          if (state.stateLoad is SuccessfulMoreData) {
            // ngăn cản sự loadmore quá nhiều khi scroll đạt tới ngưỡng quy định
            _isLoading = false;
          }
          if (state.stateLoad is LoadDataEmtpy) {
            _page--;
            _canLoadMore = false;
            _isLoading = false;
          }
        }
      });
    //listen date event new post from pusher
    _pusherClient.initPusher(
      onEvent: (event) {
        if (event.data.isNotEmpty) {
          AppSnackbar.showMessage("Has a new notification");
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
            _scrollController.position.pixels >
                _scrollController.position.maxScrollExtent - _thresholdPixel) {
          // Only scroll when _canLoadMore = true and _isLoading = false
          if (_canLoadMore && !_isLoading) {
            _page++;
            _isLoading = true;
            _homeBloc.add(LoadMorePostEvent(page: _page, limit: _limit));
          }
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    indexPage.dispose();
    // _authBloc.close();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CommentBloc>(),
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) {
            if (current is HomeSuccessfulState) {
              return current.isLoadMore == true &&
                  current.stateLoad is LoadDataInit &&
                  current.listPost.isNotEmpty;
            }
            return previous != current;
          },
          builder: (context, state) {
            if (state is HomeSuccessfulState) {
              return BottomNavHome(
                onTap: (int index) {
                  indexPage.value = index;
                  if (index == 0) {
                    // _scrollController.animateTo(0.0,
                    //     duration: const Duration(milliseconds: 450),
                    //     curve: Curves.linear);
                  }
                },
              );
            }
            return const SizedBox();
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
            },
          ),
        ),
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
        child: BlocConsumer<HomeBloc, HomeState>(
          listenWhen: (previous, current) => current is HomeErrorState,
          listener: (context, state) {
            if (state is HomeErrorState) {
              if (state.message == unauthorized) {
                PopupControl.instance.showTokenExpired(
                  context,
                  () {
                    context.read<AuthBloc>().add(LogoutUser());
                  },
                );
              }
            }
          },
          buildWhen: (previous, current) {
            if (current is HomeSuccessfulState) {
              return current.isLoadMore == true &&
                  current.stateLoad is LoadDataInit &&
                  current.listPost.isNotEmpty;
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
                  _canLoadMore = true;
                  _isLoading = false;

                  _homeBloc.add(OnRefreshDataEvent(page: _page, limit: _limit));
                },
                child: Scrollbar(
                  child: CustomScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
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
                ),
              );
            }
            return const SizedBox();
          },
        ),
      );
}
