import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppSecureStorageService {
  // Instance of FlutterSecureStorage for secure storage
  final FlutterSecureStorage _secureStorage;

  // Private constructor
  AppSecureStorageService._internal()
      : _secureStorage = const FlutterSecureStorage(
            iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock),
            aOptions: AndroidOptions(encryptedSharedPreferences: true));

  // Single instance
  static final AppSecureStorageService _instance =
      AppSecureStorageService._internal();

  // Public method to access the instance
  factory AppSecureStorageService() => _instance;

  /// Write a key-value pair securely
  Future<void> write(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  /// Read a value securely by key
  Future<String?> read(String key) async {
    return await _secureStorage.read(key: key);
  }

  /// Delete a specific key
  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  /// Delete all stored keys
  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }
}
