import 'package:encrypt/encrypt.dart' as encrypt;

class Encryption{
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  // Get encrypted
  static encrypt.Encrypted getEncrypted({required String base64}){
    return encrypt.Encrypted.fromBase64(base64);
  }

  static encrypt.Encrypted encryptAES({required String text}) {
    return encrypter.encrypt(text, iv: iv);
  }

  static String decryptAES({required encrypt.Encrypted text}) {
    return encrypter.decrypt(text, iv: iv);
  }
}