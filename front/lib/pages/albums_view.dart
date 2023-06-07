// import 'package:flutter/material.dart';
// // import 'package:front/pages/photos_view.dart';
// import 'package:front/models/album_model.dart';
// // import 'package:front/models/photo_model.dart';
// import 'dart:convert';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:http/http.dart' as http;
// // import 'package:flutter_dotenv/flutter_dotenv.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// class AlbumPage extends StatefulWidget {
//   const AlbumPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _AlbumPageState createState() => _AlbumPageState();
// }


// class _AlbumPageState extends State<AlbumPage> {
//   late Future<List<Album>> futureAlbums;

 

 

//   // Future<List<Album>> fetchAlbums() async {
//   //   final apiUrl = dotenv.env['API_URL'];

//   //   final response = await http.get(Uri.parse('$apiUrl/albums/albums/1'));

//   //   if (response.statusCode == 200) {
//   //     final List<dynamic> data = json.decode(response.body);
//   //     final List<Album> albums = [];

//   //     for (final albumData in data) {
//   //       final album = Album.fromJson(albumData);
//   //       album.photos = await fetchPhotosForAlbum(album.id);
//   //       albums.add(album)
//   //     }
//   //   }

//   //   return albums;
//   // }

//   // final List<Album> albums = [
//   //   Album(
//   //     id: 1,
//   //     title: 'Vacation',
//   //     photos: [
//   //       Photo(url: 'assets/images/a.png', title: 'Photo 1'),
//   //       Photo(url: 'assets/images/a.png', title: 'Photo 2'),
//   //       Photo(url: 'assets/images/a.png', title: 'Photo 3'),
//   //     ],
//   //   ),
//   //   Album(
//   //     id: 2,
//   //     title: 'Hello',
//   //     photos: [
//   //       Photo(url: 'assets/images/a.png', id: 'Photo 1'),
//   //       Photo(url: 'assets/images/a.png', id: 'Photo 2'),
//   //       Photo(url: 'assets/images/a.png', title: 'Photo 3'),
//   //     ],
//   //   ),
//   //   Album(
//   //     id: 3,
//   //     title: 'Pêche',
//   //     photos: [
//   //       Photo(url: 'assets/images/a.png', title: 'Photo 1'),
//   //       Photo(url: 'assets/images/b.png', title: 'Photo 2'),
//   //       Photo(url: 'assets/images/a.png', title: 'Photo 3'),
//   //     ],
//   //   ),
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Albums',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Albums'),
//         ),
//         // body: ListView.builder(
//         //   itemCount: albums.length,
//         //   itemBuilder: (BuildContext context, int index) {
//         //     return ListTile(
//         //       title: Text(albums[index].title),
//         //       onTap: () {
//         //         Navigator.push(
//         //           context,
//         //           MaterialPageRoute(
//         //             builder: (context) => PhotosScreen(album: albums[index]),
//         //           ),
//         //         );
//         //       },
//         //     );
//         //   },
//         // ),
//         body: Center(
//           child: FutureBuilder<List<Album>>(
//             future: futureAlbums,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 List<Album> albums = snapshot.data!;
//                 return ListView.builder(
//                   itemCount: albums.length,
//                   itemBuilder: (context, index) {
//                     Album album = albums[index];
//                     return ListTile(
//                       title: Text(album.title),
//                       onTap: () {
//                         // Do something when an album is tapped
//                       },
//                     );
//                   },
//                 );
//               } else if (snapshot.hasError) {
//                 return Text("${snapshot.error}");
//               }
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
