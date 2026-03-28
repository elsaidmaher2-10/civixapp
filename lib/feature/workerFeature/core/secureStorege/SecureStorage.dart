import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  late final FlutterSecureStorage _storage;

  SecureStorage._internal() {
    _storage = const FlutterSecureStorage();
  }
  static final SecureStorage _instance = SecureStorage._internal();
  factory SecureStorage() => _instance;
  Future<String?> readKey({required String key}) async {
    return await _storage.read(key: key);
  }

  Future<void> writeKey({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }
}
