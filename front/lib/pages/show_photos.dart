import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:front/providers/photo_provider.dart';
import 'package:front/services/api.dart';
import 'package:provider/provider.dart';

class ShowPhotos extends StatefulWidget {
  const ShowPhotos({super.key});

  @override
  State<ShowPhotos> createState() => _ShowPhotosState();
}

class _ShowPhotosState extends State<ShowPhotos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Erreur lors du chargement des photos",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
    // return ListView.builder(
    // itemCount: movieTitle.length,
    // itemBuilder: (BuildContext context, int index) {
    //   return Card(
    //     child: Padding(
    //       padding: const EdgeInsets.all(10.0),
    //       child: Column(
    //         children: [
    //           Text("${movieTitle[index].title}"),
    //           Text("${movieTitle[index].shortDescription}>"),
    //         ],
    //       ),
    //     ),
    //   );
    // }),
  }
}
