import 'package:flutter/material.dart';
import 'package:post_media_social/common/popup/widgets/show_auth_error.dart';
import 'package:post_media_social/common/popup/widgets/show_auth_success.dart';

class PopupControl {
  PopupControl._();

  static PopupControl instance = PopupControl._();

  void showAuthSuccess({
    required BuildContext context,
  }) async {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return ShowAuthSuccess(size: size);
      },
    );
  }

  void showAuthError({
    required BuildContext context,
  }) async {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return ShowAuthError(size: size);
      },
    );
  }
}
