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
    apiKey: 'AIzaSyB1femgEMlxwBS-uGukRdgBBYXsj3CYXeA',
    appId: '1:1077867773838:web:b40af99da94d3ba7dfeedf',
    messagingSenderId: '1077867773838',
    projectId: 'aplikasi-chat-aa4e9',
    authDomain: 'aplikasi-chat-aa4e9.firebaseapp.com',
    storageBucket: 'aplikasi-chat-aa4e9.appspot.com',
    measurementId: 'G-D7GFHVKWL4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5u3z78-MJBEYbkLfo08-RyMVoVUtumN0',
    appId: '1:1077867773838:android:b714829ea6498f40dfeedf',
    messagingSenderId: '1077867773838',
    projectId: 'aplikasi-chat-aa4e9',
    storageBucket: 'aplikasi-chat-aa4e9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZPR8cV2ZWzHvSOLoQc1NNfSON_Gt0t6I',
    appId: '1:1077867773838:ios:a1e845d8db795737dfeedf',
    messagingSenderId: '1077867773838',
    projectId: 'aplikasi-chat-aa4e9',
    storageBucket: 'aplikasi-chat-aa4e9.appspot.com',
    androidClientId: '1077867773838-nt3srv5ckdttocigkgmdskc9ok1r4ler.apps.googleusercontent.com',
    iosClientId: '1077867773838-g1p50eompr2uhb9tuqpg5ciqbs3362bn.apps.googleusercontent.com',
    iosBundleId: 'com.example.sipuanApp',
  );
}