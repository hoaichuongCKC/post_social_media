import 'package:intl/intl.dart';

extension StringX on String {
  String getCurrentTimePost() {
    //convert date format string
    final day = DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.parse(this));
    final dateNow = DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now());

    //convert string format date
    final dateOneConvert = DateTime.parse(day);
    final dateNowConvert = DateTime.parse(dateNow);

    //handle datetime
    if (dateNow.substring(0, 10).compareTo(day.substring(0, 10)) == 0) {
      if (dateNowConvert.difference(dateOneConvert).inHours != 0) {
        return "${dateNowConvert.difference(dateOneConvert).inHours} hours ago";
      } else if (dateNowConvert.difference(dateOneConvert).inMinutes != 0) {
        return "${dateNowConvert.difference(dateOneConvert).inMinutes} minutes ago";
      } else {
        return "Just finished";
      }
    } else {
      return day.substring(0, 10);
    }
  }

  bool checkToday() {
    //convert date format string
    final day = DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.parse(this));
    final dateNow = DateFormat('yyyy-MM-dd').add_Hms().format(DateTime.now());
    if (dateNow.substring(0, 10).compareTo(day.substring(0, 10)) == 0) {
      return true;
    }
    return false;
  }
}
