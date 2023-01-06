import 'dart:async';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:post_media_social/config/export.dart';

class ImageCompressService {
  final Completer<Size> _completer = Completer();

  Future<Size> calculateImageDimension(String url) {
    Image image =
        Image(image: CachedNetworkImageProvider(url)); // I modified this line
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          _completer.complete(size);
        },
      ),
    );
    return _completer.future;
  }

  Future<File> compressAndGetFile(File file, String targetPath,
      {Size size = const Size(1920, 1080)}) async {
    final filePath = file.absolute.path;

    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));

    final splitted = filePath.substring(0, (lastIndex));

    final outPath =
        "${splitted}_${targetPath}_out${filePath.substring(lastIndex)}";

    var result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
    );

    return result!;
  }

  Future<List<File>> compressAndGetListFile(
      List<XFile> listFile, String targetPath,
      {Size size = const Size(1920, 1080)}) async {
    List<File> data = [];
    for (var file in listFile) {
      final filePath = File(file.path).absolute.path;

      final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));

      final splitted = filePath.substring(0, (lastIndex));

      final outPath =
          "${splitted}_${targetPath}_out${filePath.substring(lastIndex)}";

      var result = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
      );

      if (result != null) {
        data.add(result);
      }
    }

    return data;
  }
}
