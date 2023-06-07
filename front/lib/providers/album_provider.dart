import "package:flutter/material.dart";
import "package:front/models/album_model.dart";
import "package:front/models/photo_by_album_id.dart";
import "package:front/services/api.dart";

class AlbumProvider extends ChangeNotifier {
  final _api = Api();
  List<Album> _albums = [];
  List<Album> get albums => _albums;

  List<PhotosByAlbumId> _photosBAId = [];
  List<PhotosByAlbumId> get photosBAId => _photosBAId;

  Future<void> getAlbumsByO() async {
    final res = await _api.getAlbumsByOwner();
    _albums = res;
    notifyListeners();
  }

  Future<void> getPhotosByAId(albumId) async {
    final res = await _api.getPhotosByAlbumId(albumId);
    _photosBAId = res;
    notifyListeners();
  }
}
