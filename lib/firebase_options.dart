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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyA6niW-nROeDwx6hCF7dUoza7TrKixm14U',
    appId: '1:403090223370:web:87d6c82dd35e60a80f8af3',
    messagingSenderId: '403090223370',
    projectId: 'space-voyage-56c4a',
    authDomain: 'space-voyage-56c4a.firebaseapp.com',
    databaseURL: 'https://space-voyage-56c4a-default-rtdb.firebaseio.com',
    storageBucket: 'space-voyage-56c4a.appspot.com',
    measurementId: 'G-XV021Y2CJT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8XE9JAce-sM1tBDJuzeSf9K9wSymJ8FM',
    appId: '1:403090223370:android:e1fed52a9d37bbf30f8af3',
    messagingSenderId: '403090223370',
    projectId: 'space-voyage-56c4a',
    databaseURL: 'https://space-voyage-56c4a-default-rtdb.firebaseio.com',
    storageBucket: 'space-voyage-56c4a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCSFJRB4koVSaehvV2k6mcbK1BrRRq0xWI',
    appId: '1:403090223370:ios:11e909143e3a28a40f8af3',
    messagingSenderId: '403090223370',
    projectId: 'space-voyage-56c4a',
    databaseURL: 'https://space-voyage-56c4a-default-rtdb.firebaseio.com',
    storageBucket: 'space-voyage-56c4a.appspot.com',
    iosClientId: '403090223370-almtq7jl91lp8ar25ejl1i744jch7ovi.apps.googleusercontent.com',
    iosBundleId: 'com.example.spaceVoyage',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCSFJRB4koVSaehvV2k6mcbK1BrRRq0xWI',
    appId: '1:403090223370:ios:a6946de9b177d40c0f8af3',
    messagingSenderId: '403090223370',
    projectId: 'space-voyage-56c4a',
    databaseURL: 'https://space-voyage-56c4a-default-rtdb.firebaseio.com',
    storageBucket: 'space-voyage-56c4a.appspot.com',
    iosClientId: '403090223370-49fgm9nclbersg3sfpofl3r7fnqc6tf6.apps.googleusercontent.com',
    iosBundleId: 'com.example.spaceVoyage.RunnerTests',
  );
}
