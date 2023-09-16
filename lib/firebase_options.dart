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
    apiKey: 'AIzaSyAvOBfvLTppEaYhKO5VX9b1gfvwYhKH5DI',
    appId: '1:3916919954:web:19777f1dd815e37ebfe24b',
    messagingSenderId: '3916919954',
    projectId: 'fir-class-e8fd7',
    authDomain: 'fir-class-e8fd7.firebaseapp.com',
    storageBucket: 'fir-class-e8fd7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBsZ2eRk-_dc3iwDY16BZ_Rg-2yhIa9LYg',
    appId: '1:3916919954:android:9b7a20efabed6116bfe24b',
    messagingSenderId: '3916919954',
    projectId: 'fir-class-e8fd7',
    storageBucket: 'fir-class-e8fd7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXGw_rY7iU00FVqBqywYohQyPe7ix8TpE',
    appId: '1:3916919954:ios:a43423a0b2a43e90bfe24b',
    messagingSenderId: '3916919954',
    projectId: 'fir-class-e8fd7',
    storageBucket: 'fir-class-e8fd7.appspot.com',
    iosBundleId: 'com.example.class22flutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCXGw_rY7iU00FVqBqywYohQyPe7ix8TpE',
    appId: '1:3916919954:ios:0905d38e02bf1518bfe24b',
    messagingSenderId: '3916919954',
    projectId: 'fir-class-e8fd7',
    storageBucket: 'fir-class-e8fd7.appspot.com',
    iosBundleId: 'com.example.class22flutter.RunnerTests',
  );
}