import 'package:post_media_social/config/export.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FractionallySizedBox(
              heightFactor: 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Hello Jotaro',
                    style: GoogleFonts.robotoMono(
                      fontSize: 22.0,
                      color: AppColors.dark,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'What would you like to post today?',
                    style: GoogleFonts.robotoMono(
                      fontSize: 16.0,
                      color: AppColors.dark.withOpacity(0.6),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CircleAvatar(
            // backgroundColor: AppColors.light,
            backgroundImage: const CachedNetworkImageProvider(
              "https://staticg.sportskeeda.com/editor/2022/06/508cd-16557590423635-1920.jpg",
            ),
            radius: size.width * 0.12,
          )
        ],
      ),
    );
  }
}
