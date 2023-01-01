import 'package:post_media_social/config/export.dart';

class PopupUploadPostControl {
  PopupUploadPostControl._();

  static PopupUploadPostControl instance = PopupUploadPostControl._();

  void showUploadSuccessful({
    required BuildContext context,
  }) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle,
            size: 50,
            color: AppColors.success,
          ),
          content: Text(
            "Upload post successfull!!",
            style: GoogleFonts.robotoMono(
              fontSize: 14.0,
              color: AppColors.dark,
            ),
          ),
        );
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
}
