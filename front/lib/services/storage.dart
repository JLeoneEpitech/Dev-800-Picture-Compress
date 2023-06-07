import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static final Storage _instance = Storage._internal();
  factory Storage() {
    return _instance;
  }
  static FlutterSecureStorage storage = const FlutterSecureStorage();
  static void init() {
    storage = const FlutterSecureStorage();
  }

  Future<String?> getString(String key) async {
    try {
      return await storage.read(key: key);
    } catch (e) {
      throw ("Impossible d'accéder aux variables d'environnement.");
    }
  }

  static Future<void> setString(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Storage._internal();
}