import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:front/services/api.dart';
import 'package:front/services/compression.dart';
import 'package:front/widgets/waiting_pleaase.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prenez votre photo :)')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            if (!mounted) return;

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the image to
                  // the DisplayPictureScreen widget.
                  image: image,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final XFile image;

  const DisplayPictureScreen({super.key, required this.image});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  bool isCompressing = false;

  void _Compressing() async {
    File compressedFile = await FlutterNativeImage.compressImage(
        widget.image.path,
        quality: 20,
        percentage: 20);
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => Scaffold(
                appBar: AppBar(
                    title: const Text('Aperçu de votre image compressée')),
                body: Scaffold(
                  body: SafeArea(
                    child: SingleChildScrollView(
                        child: Align(
                      alignment: Alignment
                          .topCenter, // This will horizontally center from the top
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black87, width: 5)),
                            child: Image.file(File(compressedFile.path)),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                              onPressed: () {
                                //Send the picture
                                print("pressed");
                                String fileName =
                                    compressedFile.path.split('/').last;
                                Api.postPicture(fileName, 1);
                                Api.postPictureOnFtp(compressedFile);
                                Navigator.pushReplacementNamed(
                                    context, "/take");
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    content: Text(
                                        "Votre photo ${compressedFile.path.split('/').last} à bien été publié dans votre album 'par défaut'"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(ctx, '/home');
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(14),
                                          child: const Text("okay"),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text("Publier")),
                          const SizedBox(height: 20),
                        ],
                      ),
                    )),
                  ),
                ),
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aperçu de votre image')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Image.file(File(widget.image.path)),
                    const SizedBox(height: 5),
                    Text(widget.image.name),
                    const SizedBox(height: 5),
                    ElevatedButton(
                        onPressed: _Compressing,
                        child: const Text("Compresser")),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
