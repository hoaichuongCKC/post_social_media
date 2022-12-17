import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:post_media_social/config/colors.dart';

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
                  const Text(
                    'Hello Jotaro',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: AppColors.dark,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'What would you like to post today?',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppColors.dark.withOpacity(0.6),
                      fontWeight: FontWeight.w300,
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
