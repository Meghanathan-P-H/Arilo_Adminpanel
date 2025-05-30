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
    apiKey: 'AIzaSyDG304dL6RhrIoNAuZ8EX8NjM7uQNk0UO4',
    appId: '1:1016873297812:web:c7ea63a01426e39bae1181',
    messagingSenderId: '1016873297812',
    projectId: 'arilo-ecommerce-87bb6',
    authDomain: 'arilo-ecommerce-87bb6.firebaseapp.com',
    storageBucket: 'arilo-ecommerce-87bb6.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDtaUZROlExLh2SYCI2czr7lqOyPaQp0iI',
    appId: '1:1016873297812:android:95952b086c8316e4ae1181',
    messagingSenderId: '1016873297812',
    projectId: 'arilo-ecommerce-87bb6',
    storageBucket: 'arilo-ecommerce-87bb6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrnFUO8ypB4sZGksCK0t5W4uY1_3vb704',
    appId: '1:1016873297812:ios:625e8152750285e2ae1181',
    messagingSenderId: '1016873297812',
    projectId: 'arilo-ecommerce-87bb6',
    storageBucket: 'arilo-ecommerce-87bb6.firebasestorage.app',
    androidClientId: '1016873297812-6sh5c5kdk7k70bkqoafu6da1n0slidd7.apps.googleusercontent.com',
    iosClientId: '1016873297812-t3500n5opbc94vfp50dmfars9i76pei3.apps.googleusercontent.com',
    iosBundleId: 'com.example.ariloAdmin',
  );
}
