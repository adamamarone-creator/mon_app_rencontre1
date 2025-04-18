// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyD0EXb20gnByDaOSUcP6xpSHrZjaUvj2-s',
    appId: '1:311301799214:web:8e57304590dabc8ab98ebf',
    messagingSenderId: '311301799214',
    projectId: 'senrencontre',
    authDomain: 'senrencontre.firebaseapp.com',
    storageBucket: 'senrencontre.firebasestorage.app',
    measurementId: 'G-VZMSNTT7X2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANgooWAVqtcbqzgEhT4KuFA2h-nuM6ukA',
    appId: '1:311301799214:android:a7f30938e8b3349ab98ebf',
    messagingSenderId: '311301799214',
    projectId: 'senrencontre',
    storageBucket: 'senrencontre.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2JQa6rwb8D50L9aAJt90NscyJl9yutng',
    appId: '1:311301799214:ios:be82d95081b8b986b98ebf',
    messagingSenderId: '311301799214',
    projectId: 'senrencontre',
    storageBucket: 'senrencontre.firebasestorage.app',
    iosBundleId: 'com.example.monAppRencontre',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB2JQa6rwb8D50L9aAJt90NscyJl9yutng',
    appId: '1:311301799214:ios:be82d95081b8b986b98ebf',
    messagingSenderId: '311301799214',
    projectId: 'senrencontre',
    storageBucket: 'senrencontre.firebasestorage.app',
    iosBundleId: 'com.example.monAppRencontre',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD0EXb20gnByDaOSUcP6xpSHrZjaUvj2-s',
    appId: '1:311301799214:web:c3fc6fbf18ed2871b98ebf',
    messagingSenderId: '311301799214',
    projectId: 'senrencontre',
    authDomain: 'senrencontre.firebaseapp.com',
    storageBucket: 'senrencontre.firebasestorage.app',
    measurementId: 'G-YLEPLEMBSC',
  );
}
