import 'package:get_storage/get_storage.dart';

class StorageService {
  static final GetStorage _storage = GetStorage("otkEmployee");

  static Future<void> write(String key, dynamic value) async {
    await _storage.write(key, value);
    await _storage.save();
  }

  static T? read<T>(String key) {
    return _storage.read<T>(key);
  }

  static Future<void> remove(String key) async {
    await _storage.remove(key);
    await _storage.save();
  }

  static Future<void> clear() async {
    await _storage.erase();
    await _storage.save();
  }

  static bool hasData(String key) {
    return _storage.hasData(key);
  }
}
