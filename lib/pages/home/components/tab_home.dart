import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:post_media_social/config/colors.dart';

class TabHome extends StatelessWidget {
  const TabHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 60,
        minHeight: 40,
      ),
      child: SizedBox(
        width: double.infinity,
        height: size.height * .05,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTab(
                urlIcon: "file.svg",
                text: "New post",
                main: MainAxisAlignment.start),
            _buildTab(
                urlIcon: "clipboard.svg",
                text: "My post",
                main: MainAxisAlignment.center),
            _buildTab(
                urlIcon: "notification.svg",
                text: "Notification",
                main: MainAxisAlignment.end),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(
          {required String urlIcon,
          required String text,
          required MainAxisAlignment main}) =>
      Expanded(
        child: Row(
          mainAxisAlignment: main,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/$urlIcon",
              width: 18.0,
              height: 18.0,
            ),
            const SizedBox(width: 5.0),
            Text(
              text,
              style: TextStyle(
                fontSize: 14.0,
                color: AppColors.dark.withOpacity(0.6),
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
      );
}
