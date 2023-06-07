import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:front/pages/album_page.dart';
import 'package:front/pages/compress.dart';
import 'package:front/pages/home.dart';
import 'package:front/pages/intro.dart';
import 'package:front/pages/login.dart';
import 'package:front/pages/register.dart';
import 'package:front/globals/decoration.dart';
import 'package:front/pages/show_photos.dart';
import 'package:front/pages/take_pictures.dart';

class App extends StatelessWidget {
  final CameraDescription firstCamera;
  const App({super.key, required this.firstCamera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      title: 'PictsManager',
      initialRoute: '/intro',
      routes: {
        '/intro': (context) => const IntroPage(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/compress': (context) => const compressPage(),
        '/home': (context) => HomePage(camera: firstCamera),
        '/album': (context) => const AlbumPage(),
        '/take': (context) => TakePictureScreen(
              camera: firstCamera,
            ),
        '/photos': (context) => const ShowPhotos(),
      },
    );
  }
}
