import 'package:post_media_social/common/popup/widgets/show_auth_error.dart';
import 'package:post_media_social/common/popup/widgets/show_auth_success.dart';
import 'package:post_media_social/config/export.dart';

class PopupControl {
  PopupControl._();

  static PopupControl instance = PopupControl._();

  void showAuthSuccess({
    required BuildContext context,
  }) async {
    final size = MediaQuery.of(context).size;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return ShowAuthSuccess(size: size);
      },
    );
  }

  void showAuthError({
    required BuildContext context,
    required String error,
  }) async {
    final size = MediaQuery.of(context).size;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return ShowAuthError(size: size, error: error);
      },
    );
  }

  void showLoading(BuildContext context, Size size) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: size.width * 0.5,
          height: 50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: spinkit),
            ],
          ),
        ),
      ),
    );
  }

  void showTokenExpired(BuildContext context, Function() onPressed) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning, size: 25.0, color: Colors.yellow),
            const SizedBox(width: 10.0),
            Text(
              'Warning',
              style: GoogleFonts.robotoMono(
                fontSize: 16.0,
              ),
              maxLines: 2,
            ),
          ],
        ),
        content: Text(
          'Token has Expired, login again please',
          style: GoogleFonts.robotoMono(
            fontSize: 13.0,
          ),
          maxLines: 2,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: onPressed,
            child: Text(
              'Logout',
              style: GoogleFonts.robotoMono(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
