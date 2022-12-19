import 'package:post_media_social/common/popup/notification/popup_noti_control.dart';
import 'package:post_media_social/config/export.dart';
import 'package:post_media_social/pages/notification/components/item_noti.dart';

final List<Map> listNotiToday = [
  {
    "avatarUrl":
        "https://vtv1.mediacdn.vn/thumb_w/650/2019/2/20/img2-1550631553056774692039.jpg",
    "username": "Hoàng Yến",
    "comment": "Đẹp trai quá",
    "image_post":
        "https://vcdn1-giaitri.vnecdn.net/2022/10/24/-8754-1666626354.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=lbOz-YmE5jN8fir7u2R0Ng",
    "created_at": 1,
  },
  {
    "avatarUrl":
        "https://nld.mediacdn.vn/291774122806476800/2022/8/8/1-16599673874711436824945.jpeg",
    "username": "Chi pu",
    "comment": "Hôm nay bạn hát thật hay",
    "image_post":
        "https://vcdn1-giaitri.vnecdn.net/2022/10/24/-8754-1666626354.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=lbOz-YmE5jN8fir7u2R0Ng",
    "created_at": 3,
  }
];

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final GlobalKey appbarKey = GlobalKey();
  final listKey = GlobalKey<SliverAnimatedListState>();
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
            style: GoogleFonts.robotoMono(
              fontSize: 22.0,
              color: AppColors.dark,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InkWell(
                onTap: () {
                  PopupNotiControl.instance.showOption(appbarKey, context);
                },
                radius: 80.0,
                customBorder: const CircleBorder(),
                child: SvgPicture.asset(
                  "assets/icons/dot.svg",
                ),
              ),
            ),
          ],
          actionsIconTheme: const IconThemeData(color: AppColors.dark),
        ),
        backgroundColor: AppColors.light,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                sliver: SliverToBoxAdapter(
                  child: Wrap(
                    children: [
                      Text(
                        'You have ',
                        style: GoogleFonts.robotoMono(
                          fontSize: 14.0,
                          color: AppColors.dark.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        '2 notifications ',
                        style: GoogleFonts.robotoMono(
                          fontSize: 14.0,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        'today',
                        style: GoogleFonts.robotoMono(
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
                  style: GoogleFonts.robotoMono(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                sliver: SliverAnimatedList(
                  key: listKey,
                  initialItemCount: listNotiToday.length,
                  itemBuilder: (context, index, animation) {
                    final result = listNotiToday[index];
                    final keyItem = GlobalKey();
                    return InkWell(
                      onLongPress: () {
                        PopupNotiControl.instance.showDeleteItem(
                          context,
                          onTap: () {
                            listNotiToday.removeAt(index);
                            listKey.currentState!.removeItem(
                              index,
                              duration: const Duration(milliseconds: 300),
                              (context, animation) => ItemNoti(
                                result: result,
                                animation: animation,
                              ),
                            );
                            AppRoutes.pop();
                          },
                        );
                      },
                      onTap: () {},
                      child: ItemNoti(
                        key: keyItem,
                        result: result,
                        animation: animation,
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  "This week",
                  style: GoogleFonts.robotoMono(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
