import 'dart:io';
import 'dart:ui' as ui;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:front/globals/exceptions.dart';
import 'package:front/models/helper_picked_file.dart';

class FileHelper {
  static final FileHelper _instance = FileHelper._internal();
  factory FileHelper() {
    return _instance;
  }

  /// Prevent unwanted extensions (GIF, ...).
  List<String> imageExtensionsAllowed = [
    'png',
    'jpg',
    'jpeg',
  ];

  /// Images are limited to 800 X 500.
  int width = 800;
  int height = 500;

  /// Uploads are limited to 8MB (8388608 bytes).
  double sizeLimit = 8;

  void _size(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb > sizeLimit) {
      throw FileSize();
    }
  }

  void _extension(File file) {
    String extension = file.path.split('.').last;
    if (!imageExtensionsAllowed.contains(extension)) {
      throw FileExtension();
    }
  }

  Future<void> _dimension(File file) async {
    ui.Image decodedImage = await decodeImageFromList(file.readAsBytesSync());
    if (decodedImage.width < width || decodedImage.height < height) {
      throw FileDimension();
    }
  }

  // renvoi des messages d'erreur si des upload ont foirées ?
  // créer un model spécial pour return deux valeurs ?
  Future<HelperPickedFiles> pickPictures() async {
    List<File> files = [];
    List<Exception> exceptions = [];

    /// Show the FilePicker to the user and wait for them to pick the files
    FilePickerResult? pickerResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    /// If the user canceled the picker, we return a empty array.
    if (pickerResult == null || pickerResult.files.isEmpty) {
      return HelperPickedFiles(exceptions: [], files: []);
    }

    for (PlatformFile picked in pickerResult.files) {
      try {
        File file = File(picked.path!);
        await _dimension(file);
        _extension(file);
        _size(file);
        files.add(file);
      } catch (exception) {
        if (!exceptions.contains(exception)) {
          exceptions.add(exception as Exception);
        }
      }
    }
    return HelperPickedFiles(exceptions: exceptions, files: files);
  }

  FileHelper._internal();
}
