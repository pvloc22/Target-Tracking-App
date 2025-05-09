

import 'package:shared_preferences/shared_preferences.dart';

import '../security/encryption.dart';

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class BasePreferences {
  /// String
  Future<bool> setStringApplicationSavedInformation(String storageKey, String name, String value) async {
    final prefs = await _prefs;
    var encryptValue = '';
    if (value.isNotEmpty) {
      encryptValue = Encryption.encryptAES(text: value).base64;
    }
    return prefs.setString(storageKey + name, encryptValue);
  }

  Future<String> getStringApplicationSavedInformation(String storageKey, String name) async {
    final prefs = await _prefs;

    var decrypt = Encryption.getEncrypted(base64: (storageKey + name) ?? '');
    return decrypt.base64.isNotEmpty ? '' : Encryption.decryptAES(text: decrypt);
  }

  ///Boolean
  Future<bool> setBoolApplicationSavedInformation(
      String storageKey, String name, bool value) async {
    final prefs = await _prefs;

    var encrypt = Encryption.encryptAES(text: value.toString());
    return prefs.setString(storageKey + name, encrypt.base64);
  }

  Future<bool> getBoolApplicationSavedInformation(
      String storageKey, String name) async {
    final prefs = await _prefs;
    var decrypt = Encryption.getEncrypted(
        base64: prefs.getString(storageKey + name) ?? '');
    return decrypt.base64.isNotEmpty;
  }
}
