import 'dart:io';

import '../../config/export.dart';

class CameraSeviceApp {
  final _picker = ImagePicker();

  Future pickImage() async {
    XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      return File(file.path);
    }
  }
}
