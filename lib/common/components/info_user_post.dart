import 'package:post_media_social/config/export.dart';

class InfoUserPost extends StatelessWidget {
  const InfoUserPost(
      {super.key,
      this.maxHeight = 60,
      this.minHeight = 50,
      required this.height,
      this.isComment = false});
  final double maxHeight;
  final double minHeight;
  final double height;
  final bool isComment;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
        minHeight: minHeight,
      ),
      child: SizedBox(
        width: size.width,
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      backgroundImage: const CachedNetworkImageProvider(
                          "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/a0d4ce8e-23c7-4ee4-bdb9-a477f642ffb2/denbqdt-f5c83159-2b8f-4555-974d-b1069e7542f4.jpg/v1/fill/w_400,h_534,q_75,strp/jolyne_kujo_fanart_by_pandamander_denbqdt-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2EwZDRjZThlLTIzYzctNGVlNC1iZGI5LWE0NzdmNjQyZmZiMlwvZGVuYnFkdC1mNWM4MzE1OS0yYjhmLTQ1NTUtOTc0ZC1iMTA2OWU3NTQyZjQuanBnIiwiaGVpZ2h0IjoiPD01MzQiLCJ3aWR0aCI6Ijw9NDAwIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLndhdGVybWFyayJdLCJ3bWsiOnsicGF0aCI6Ilwvd21cL2EwZDRjZThlLTIzYzctNGVlNC1iZGI5LWE0NzdmNjQyZmZiMlwvcGFuZGFtYW5kZXItNC5wbmciLCJvcGFjaXR5Ijo5NSwicHJvcG9ydGlvbnMiOjAuNDUsImdyYXZpdHkiOiJjZW50ZXIifX0.iF3hxWGYZbmyqTcCeQ3Mzbvdm_1RK9nA2zaQAxF3HRU"),
                      backgroundColor: Colors.transparent,
                      radius: isComment ? 20 : 30.0,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                          flex: 1,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'KhangLakaChim',
                              style: AppStyleText.smallStyleDefault,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset("assets/icons/stopwatch.svg"),
                                const FittedBox(
                                  child: Text(
                                    '1m',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.disable,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset("assets/icons/trash.svg"),
            ),
          ],
        ),
      ),
    );
  }
}
