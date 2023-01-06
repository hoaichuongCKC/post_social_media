import 'package:post_media_social/config/export.dart';

class ImageDetailPage extends StatelessWidget {
  const ImageDetailPage({super.key, required this.urlImage});
  final String urlImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Stack(
        children: [
          SizedBox.expand(
            child: Hero(
              tag: urlImage,
              child: CachedNetworkImage(
                imageUrl: sl.get<Api>().BASE_URL + urlImage,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () => AppRoutes.pop(),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 25.0,
                    color: AppColors.light,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
