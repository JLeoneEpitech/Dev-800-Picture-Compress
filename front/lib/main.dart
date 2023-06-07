import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/app.dart';
import 'package:front/pages/album_page.dart';
import 'package:front/providers/album_provider.dart';
import 'package:front/providers/photo_provider.dart';
import 'package:provider/provider.dart';
import '../providers/register.dart';
import '../providers/login.dart';

void main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  /// Set the application oriention to portrait only.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => RegisterProvider()),
      ChangeNotifierProvider(create: (_) => PhotoProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(
        create: (context) => AlbumProvider(),
        child: const MaterialApp(home: AlbumPage()),
      ),
    ],
    child: App(firstCamera: firstCamera),
  ));

  //runApp(App(
  // firstCamera: firstCamera,
  // ));
}
