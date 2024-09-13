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
    apiKey: 'AIzaSyA30AlAehsj9IdlTcHMJlNVFMxe3Jfaxmc',
    appId: '1:868929832369:web:67199e79802fcfa4d16990',
    messagingSenderId: '868929832369',
    projectId: 'plnnr-plnnr',
    authDomain: 'plnnr-plnnr.firebaseapp.com',
    databaseURL: 'https://plnnr-plnnr-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'plnnr-plnnr.appspot.com',
    measurementId: 'G-ELNHJ1S80F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZS7KAJnJDXILpyQiFfjHKLLmVvI9-yUY',
    appId: '1:868929832369:android:e0fe3e6bcce18795d16990',
    messagingSenderId: '868929832369',
    projectId: 'plnnr-plnnr',
    databaseURL: 'https://plnnr-plnnr-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'plnnr-plnnr.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBRh5N9vcjrI1dCfxvvLsUQCgLbnPndrRU',
    appId: '1:868929832369:ios:aa78d0564fc56bf6d16990',
    messagingSenderId: '868929832369',
    projectId: 'plnnr-plnnr',
    databaseURL: 'https://plnnr-plnnr-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'plnnr-plnnr.appspot.com',
    iosBundleId: 'com.example.plnnTest1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBRh5N9vcjrI1dCfxvvLsUQCgLbnPndrRU',
    appId: '1:868929832369:ios:aa78d0564fc56bf6d16990',
    messagingSenderId: '868929832369',
    projectId: 'plnnr-plnnr',
    databaseURL: 'https://plnnr-plnnr-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'plnnr-plnnr.appspot.com',
    iosBundleId: 'com.example.plnnTest1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA30AlAehsj9IdlTcHMJlNVFMxe3Jfaxmc',
    appId: '1:868929832369:web:151a471368065030d16990',
    messagingSenderId: '868929832369',
    projectId: 'plnnr-plnnr',
    authDomain: 'plnnr-plnnr.firebaseapp.com',
    databaseURL: 'https://plnnr-plnnr-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'plnnr-plnnr.appspot.com',
    measurementId: 'G-1DKGV5ES3H',
  );
}
