import 'dart:async';
import 'dart:io';

import '../../config/export.dart';

class CameraServiceApp {
  final _picker = ImagePicker();

  Future pickImage() async {
    XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxHeight: 480,
      maxWidth: 640,
    );
    if (file != null) {
      return File(file.path);
    }
  }

  Future pickMultiImage() async {
    List<XFile>? file = await _picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 480,
      maxWidth: 640,
    );
    if (file.isNotEmpty) {
      return file;
    }
    return null;
  }
}
