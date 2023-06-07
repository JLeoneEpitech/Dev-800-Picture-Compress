import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:front/helpers/file.dart';
import 'package:front/models/helper_picked_file.dart';
import 'package:front/widgets/add_card.dart';

class compressPage extends StatefulWidget {
  const compressPage({super.key});

  @override
  State<compressPage> createState() => _compressPageState();
}

class _compressPageState extends State<compressPage> {
  bool _isPicking = false;
  final List<File> _addedPictures = [];
  final List<String> _streamedPictures = [];

  @override
  Widget build(BuildContext context) {
    void _togglePicking() {
      setState(() {
        _isPicking = !_isPicking;
      });
    }

    Future<void> _pickPictures() async {
      _togglePicking();
      HelperPickedFiles picked = await FileHelper().pickPictures();
      for (File file in picked.files) {
        if (_addedPictures.length + _streamedPictures.length >= 10) {
          print("erreurrrrrrrrr");
          break;
        }
        _addedPictures.add(file);
        print(_addedPictures);
      }

      for (Exception exception in picked.exceptions) {
        print("Exception");
        throw exception;
      }
      _togglePicking();
    }

    Widget _buildPicture({
      File? localPicture,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 150,
          constraints: const BoxConstraints(
            minWidth: 70,
            maxWidth: 400,
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(localPicture!, fit: BoxFit.fill),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildScrollablePictures() {
      if (_isPicking) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      List<Widget> children = [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: AddCard(
            onTap: _pickPictures,
            canAdd: _addedPictures.length + _streamedPictures.length < 10,
          ),
        ),
      ];

      /// Add local picked pictures.
      for (File picture in _addedPictures) {
        print(picture);
        children.add(
          _buildPicture(localPicture: picture),
        );
      }

      return SizedBox(
        height: 150,
        child: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Compresseur d'image de fou malade",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 100,
            ),
            // ElevatedButton(onPressed: _pickPictures, child: const Text("data"))
            _buildScrollablePictures(),
          ],
        ),
      )),
    );
  }
}
