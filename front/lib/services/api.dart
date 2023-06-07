import 'dart:convert';

import 'package:front/models/album_model.dart';
import 'package:front/models/photo.dart';
import 'package:front/models/photo_by_album_id.dart';
import 'package:front/services/storage.dart';
import 'package:http/http.dart' as http;
import 'package:front/globals/exceptions.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Response {
  final int code;
  final dynamic body;
  late bool isSuccess;
  late bool isNotSuccess;

  Response({required this.code, required this.body})
      : isSuccess = code == 200,
        isNotSuccess = code != 200;

  factory Response.decode(http.Response response) {
    return Response(code: response.statusCode, body: jsonDecode(response.body));
  }
}

class Api {
  static final Api _instance = Api._internal();
  factory Api() {
    return _instance;
  }

  static const String endpoint = 'http://13.37.244.2:8000';

  static Future<String> getJWT() async {
    String? jwt = await Storage().getString("JWT");

    if (jwt == null || jwt.isEmpty) {
      throw SessionException();
    }
    return jwt;
  }

  static Exception _buildException(http.Response response) {
    if (response.statusCode == 403) {
      return SessionException();
    }

    return MessageException(jsonDecode(response.body)["error"]);
  }

  static Future<void> getRegister(String password, String username) async {
    Map<String, dynamic> credentials;

    credentials = {
      "password": password,
      "username": username,
    };

    http.Response response = await http.post(
      Uri.parse('$endpoint/users/account/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(credentials),
    );

    if (response.statusCode == 201) {
    } else if (response.statusCode == 400) {
      throw MessageException("Username déjà utilisée");
    } else {
      throw _buildException(response);
    }
  }

  static Future<void> getLogin(String username, String password) async {
    Map<String, dynamic> credentials;

    credentials = {
      "username": username,
      "password": password,
    };
    print(credentials);

    http.Response response = await http.post(
      Uri.parse('$endpoint/api/token/'),
      body: credentials,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      String token = body["access"];
      await Storage.setString("JWT", token);
    } else if (response.statusCode == 401) {
      throw MessageException("Votre compte existe pas, veuillez vous inscire");
    }
  }

  static Future<void> postPicture(String name, int owner) async {
    String? jwt = await getJWT();
    print("postPicture");
    print(name.length);
    Map<String, dynamic> credentials;

    credentials = {
      "name": name,
      "owner": owner,
    };

    http.Response response = await http.post(
      Uri.parse('$endpoint/photos/photos/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
      body: jsonEncode(credentials),
    );

    print("Photo posted on DB : ${response.body}");
    if (response.statusCode == 201) {
    } else if (response.statusCode == 400) {
      throw MessageException("photos déjà utilisée");
    } else {
      throw _buildException(response);
    }
  }

  static Future<void> postPictureOnFtp(File picture) async {
    FTPConnect ftpConnect =
        FTPConnect('13.37.244.2', user: 'ftp_project', pass: 'ftp_project');
    try {
      await ftpConnect.connect();
      await ftpConnect.uploadFile(picture);
      print("Photo posted in the FTP");
      await ftpConnect.disconnect();
    } catch (e) {
      print("EROOR");
    }
  }

  ///mock a file for the demonstration example
  static Future<File> _fileMock(
      {fileName = 'FlutterTest.txt', content = ''}) async {
    final Directory directory = Directory('/test')..createSync(recursive: true);
    final File file = File('${directory.path}/$fileName');
    await file.writeAsString(content);
    return file;
  }

  static Future<File> _fileMock2({
    fileName,
  }) async {
    Directory root =
        await getTemporaryDirectory(); // this is using path_provider
    String directoryPath = root.path + '/bozzetto_camera';
    await Directory(directoryPath)
        .create(recursive: true); // the error because of this line
    String filePath = '$directoryPath/$fileName';

    return File(filePath);
  }

  static Future<void> getPictureFromFtp(Photo photo) async {
    FTPConnect ftpConnect =
        FTPConnect('13.37.244.2', user: 'ftp_project', pass: 'ftp_project');
    try {
      print(photo.name);
      await ftpConnect.connect();
      print("connected");
      //erreur d'autorisation
      await ftpConnect.downloadFile(photo.name, File(photo.name));
      await ftpConnect.disconnect();
    } catch (e) {
      print('erreur + $e');
    }
  }

  static Future<List<Photo>> getPhotosByOwner(int owner) async {
    String? jwt = await getJWT();
    final res = await http
        .get(Uri.parse('$endpoint/photos/photos/?owner=$owner'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    });
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      print("c'est 200");
      Iterable l = jsonDecode(res.body);
      print(l);
      List<Photo> posts =
          List<Photo>.from(l.map((model) => Photo.fromJson(model)));
      print(posts);
      print("xxxxxxxxxxxxxxxxxxxxxxxxx");
      return posts;

      // print("c'est 200");
      // final json = jsonDecode(res.body) as List;
      // print(json);
      // final images = json.map((e) {
      //   return Photo(id: e['id'], name: e['name'], owner: e['owner']);
      // }).toList();
      // return images;
    } else {
      throw "error";
    }
  }

  Future<List<Album>> getAlbumsByOwner() async {
    String? jwt = await getJWT();
    final res =
        await http.get(Uri.parse('$endpoint/albums/albums/?owner=1'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    });

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body) as List;
      final albums = json.map((e) {
        return Album(id: e['id'], name: e['name'], owner: e['owner']);
      }).toList();
      return albums;
    } else {
      throw "error";
    }
  }

  Future<List<PhotosByAlbumId>> getPhotosByAlbumId(int albumId) async {
    String? jwt = await getJWT();
    final res = await http.get(
        Uri.parse('$endpoint/photos/photos_in_album/?album=$albumId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt',
        });

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body) as List;
      final photos = json.map((e) {
        return PhotosByAlbumId(
            id: e['id'], photo: e['photo'], album: e['album']);
      }).toList();
      return photos;
    } else {
      throw "error hehe";
    }
  }

  Api._internal();
}
