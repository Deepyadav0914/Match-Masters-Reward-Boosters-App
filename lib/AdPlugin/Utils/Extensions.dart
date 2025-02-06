import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as enc;
import '../Ads/FullScreen/Ads.dart';

extension NavigationExtension on String {
  Future<void> performAction({
    required BuildContext context,
    required Function() onComplete,
  }) async {
    await AdsRN().showActionBasedAds(
      context: context,
      actionName: this,
      onComplete: () {
        onComplete();
      },
    );
  }

  Future<void> performScreenAction({
    required BuildContext context,
    required Function() onComplete,
  }) async {
    await AdsRN().showScreenActionBasedAds(
      context: context,
      actionName: this,
      onComplete: () {
        onComplete();
      },
    );
  }
}

extension Decryption on String {
  encrypt() {
    final key = enc.Key.fromUtf8('Happiness is a choice we make...');

    final iv =
    enc.IV.fromUtf8('Happiness is a choice we make...'.substring(0, 16));

    final encrypter = enc.Encrypter(enc.AES(key, padding: null));

    final encrypted = encrypter.encrypt(this, iv: iv);
    return encrypted.base64;
  }

  decrypt() {
    final key = enc.Key.fromUtf8('Happiness is a choice we make...');

    final iv =
    enc.IV.fromUtf8('Happiness is a choice we make...'.substring(0, 16));
    final encrypter = enc.Encrypter(enc.AES(key, padding: null));
    final decrypted = encrypter.decrypt64(this, iv: iv);
    return decrypted;
  }
}
