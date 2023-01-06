import 'export.dart';

class AppSnackbar {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showMessage(String meg) {
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.up,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        backgroundColor: AppColors.dark.withOpacity(0.8),
        content: Text(
          meg,
        ),
      ),
    );
  }
}
