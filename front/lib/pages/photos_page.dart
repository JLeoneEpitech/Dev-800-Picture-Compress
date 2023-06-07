// import 'package:flutter/material.dart';
// import 'package:front/models/album_model.dart';

// class PhotosScreen extends StatelessWidget {

//   const PhotosScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Current Photos'),
//       ),
//       body: GridView.builder(
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//         itemCount: ,
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             child: AspectRatio(
//               aspectRatio: 1.0,
//               child: Container(
//                 margin: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   // image: DecorationImage(
//                   //   // image: AssetImage(album.photos[index].url),
//                     // fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             // ),
//             onTap: () {
//               // Do something when the photo is tapped.
//             },
//           );
//         },
//       ),
//     );
//   }
// }
