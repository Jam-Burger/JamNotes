// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYhSnSJATRrU8_o5KqU8ptXV_ZY-89cvE',
    appId: '1:1013204233475:android:f1cee4475c4aea7f658d36',
    messagingSenderId: '1013204233475',
    projectId: 'jamnotes',
    storageBucket: 'jamnotes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdNZKigPJ4t4Xya69-WvVyng7-foMz4Gg',
    appId: '1:1013204233475:ios:62094f528e65ed10658d36',
    messagingSenderId: '1013204233475',
    projectId: 'jamnotes',
    storageBucket: 'jamnotes.appspot.com',
    iosClientId: '1013204233475-d0h5ho6b3fvnerofcpb1t529ssgch3pn.apps.googleusercontent.com',
    iosBundleId: 'com.jamburger.jamnotes',
  );
}