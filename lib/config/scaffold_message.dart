import 'export.dart';

class AppSnackbar {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showMessage(String meg) {
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        backgroundColor: AppColors.dark.withOpacity(0.8),
        content: Text(
          meg,
        ),
      ),
    );
  }
}
