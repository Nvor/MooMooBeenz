import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//To be extended
class SecureStorageService with ChangeNotifier {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String> get(String key) async {
    var value = await storage.read(key: key);
    return value;
  }

  Future<Map<String, String>> getAll() async {
    Map<String, String> values = await storage.readAll();
    return values;
  }

  Future<void> set(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
  }

  Future<bool> contains(String key) async {
    bool contains = await storage.containsKey(key: key);
    return contains;
  }
}