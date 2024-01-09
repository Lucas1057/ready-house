// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD_LK0gfwegsqv-yOlISUyiCCta-j72has',
    appId: '1:1025593670999:web:9f062a4329c9b0299f5212',
    messagingSenderId: '1025593670999',
    projectId: 'vendas-app-99e0b',
    authDomain: 'vendas-app-99e0b.firebaseapp.com',
    storageBucket: 'vendas-app-99e0b.appspot.com',
    measurementId: 'G-ZZBB8R9FSN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDEDK464f6sN0c_vBQXBuMh96sPS6ckXso',
    appId: '1:1025593670999:android:db6a1cc5d290f2429f5212',
    messagingSenderId: '1025593670999',
    projectId: 'vendas-app-99e0b',
    storageBucket: 'vendas-app-99e0b.appspot.com',
  );
}
