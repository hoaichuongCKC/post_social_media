import 'package:post_media_social/common/components/item_post.dart';
import 'package:post_media_social/config/export.dart';

final List<Map> listPost = [
  {
    "username": "Sơn tùng",
    "title":
        "Lần đầu ăn cua hoàng đế cả nhà ơi.\nCảm ơn mọi người thời gian qua ủng Hộ Tùng nhé",
    "urlAvatar":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Son_Tung_M-TP_1_%282017%29.png/1200px-Son_Tung_M-TP_1_%282017%29.png",
    "urlPost":
        "https://haisantrungnam.vn/wp-content/uploads/2020/03/cua-hoang-de-alaska-600x450.jpg",
  },
  {
    "username": "Đen vâu",
    "title": "Hôm nay Đen vui quá cảm ơn mng nhé.\nÂy zo what up's",
    "urlAvatar":
        "https://toquoc.mediacdn.vn/280518851207290880/2022/9/11/dv2-1662837213793527342227.png",
    "urlPost":
        "https://znews-photo.zingcdn.me/w660/Uploaded/izhqv/2019_11_10/_8103856.jpg",
  }
];

class ListPostHome extends StatelessWidget {
  const ListPostHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      initialItemCount: listPost.length,
      itemBuilder: (BuildContext ctx, int index, Animation<double> animation) {
        return ItemPost(
          urlAvatarUser: listPost[index]["urlAvatar"],
          urlPost: listPost[index]["urlPost"],
          title: listPost[index]["title"],
          username: listPost[index]["username"],
        );
      },
    );
  }
}
