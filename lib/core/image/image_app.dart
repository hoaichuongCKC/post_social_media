import 'dart:async';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:post_media_social/config/export.dart';

class ImageResolveApp {
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
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minWidth: size.width.toInt(),
      minHeight: size.height.toInt(),
      quality: 88,
    );

    print(file.lengthSync());
    print(result!.lengthSync());
    print(result.path);

    return result;
  }
}
