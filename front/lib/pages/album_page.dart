import 'package:flutter/material.dart';
import 'package:front/providers/album_provider.dart';
import 'package:provider/provider.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});
  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AlbumProvider>(context, listen: false).getAlbumsByO();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Albums"),
      ),
      body: Consumer<AlbumProvider>(builder: (context, albumProvider, child) {
        final albums = albumProvider.albums;

        return ListView.builder(
          itemCount: albums.length,
          itemBuilder: (context, index) {
            final album = albums[index];

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(album.name),
                  ),
                  Consumer<AlbumProvider>(
                    builder: (context, photoProvider, _) {
                      if (photoProvider.photosBAId.isEmpty) {
                        photoProvider.getPhotosByAId(album.id);
                      }

                      final photos = photoProvider.photosBAId
                          .where((photo) => photo.album == album.id)
                          .toList();
                      print(
                          ' Photos pour l\'album ${album.id} affichées : $photos');
                      return Column(
                        children: photos
                            .map(
                              (photo) => Text(
                                ' - ${photo.photo}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ]);
          },
        );
      }),
    );
  }
}
