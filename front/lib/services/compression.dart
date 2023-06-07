import 'dart:convert';
import 'dart:io';
import 'package:front/globals/exceptions.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;

class Compression {
  static final Compression _instance = Compression._internal();
  factory Compression() {
    return _instance;
  }

  Exception _buildException(http.Response response) {
    if (response.statusCode == 403) {
      return SessionException();
    }

    if (response.statusCode == 505) {
      return VersionNotSupported();
    }

    if (response.statusCode == 503) {
      return ServiceUnavailable();
    }
    return MessageException(jsonDecode(response.body)["message"]);
  }

  Future<File?> testCompressAndGetFile(File file, String targetPath) async {
    print("try");
    File? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
      rotate: 180,
    );

    print("path target  : + $targetPath");
    print(file.lengthSync());
    print(result?.length);
    print(result);

    return result;
  }

  Compression._internal();
}
