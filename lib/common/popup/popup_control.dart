import 'package:flutter/material.dart';
import 'package:post_media_social/common/popup/widgets/show_auth_error.dart';
import 'package:post_media_social/common/popup/widgets/show_auth_success.dart';
import 'package:post_media_social/config/constants.dart';

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
}
