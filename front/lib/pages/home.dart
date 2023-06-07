import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:front/providers/photo_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final CameraDescription camera;

  const HomePage({super.key, required this.camera});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  void _downloadImage() async {
    await context.read<PhotoProvider>().getPhotosByO(1);
    print("dl");
    Navigator.pushNamed(context, '/photos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.photo_camera_back),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.camera_alt_rounded),
            label: 'Take Picture',
          ),
          // NavigationDestination(
          //   selectedIcon: Icon(Icons.bookmark),
          //   icon: Icon(Icons.bookmark_border),
          //   label: 'Saved',
          // ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: ElevatedButton(
              onPressed: _downloadImage, child: Text("Découvrez vos photos")),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/take');
              },
              child: Text("Prendre une photo")),
          // ),
          // Container(
          //   color: Colors.blue,
          //   alignment: Alignment.center,
          //   child: const Text('Page 3'),
          // ),
        )
      ][currentPageIndex],
    );
  }
}
