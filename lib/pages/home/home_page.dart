// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:post_media_social/config/colors.dart';
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
  ValueNotifier<int> indexChanged = ValueNotifier<int>(0);
  @override
  void dispose() {
    super.dispose();
    indexChanged.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() {});
  }

  @override
  void dispose() {
    super.dispose();
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
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30.0,
            ),
          )
        ],
      ),
    );
  }
}
