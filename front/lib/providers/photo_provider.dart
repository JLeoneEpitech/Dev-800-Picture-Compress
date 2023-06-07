import "package:flutter/material.dart";
import 'package:front/models/photo.dart';
import "package:front/services/api.dart";

class PhotoProvider extends ChangeNotifier {
  List<Photo> _photos = [];
  List<Photo> get photos => _photos;

  Future<void> getPhotosByO(int owner) async {
    final res = await Api.getPhotosByOwner(owner);
    print("getPhotoByOwner done");
    _photos = res;
    print("-------------------------------------");
    print(_photos.length);
    notifyListeners();
    for (var i = 0; i < _photos.length; i++) {
      print(i);
      Api.getPictureFromFtp(_photos[i]);
    }
  }
}
