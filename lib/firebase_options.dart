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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTyYff5MDxMqc3GhSNjgKgwYaktch3HaU',
    appId: '1:643037091126:android:91387b6990a583c90f8f97',
    messagingSenderId: '643037091126',
    projectId: 'sharide-app',
    storageBucket: 'sharide-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfW7WslVnfCW0rJD8wMvqbVW7fGwtBkUY',
    appId: '1:643037091126:ios:e1ba1f0854772b1f0f8f97',
    messagingSenderId: '643037091126',
    projectId: 'sharide-app',
    storageBucket: 'sharide-app.appspot.com',
    androidClientId: '643037091126-9ai14t3pf3sa7q915v2g996gn8l7h6dm.apps.googleusercontent.com',
    iosClientId: '643037091126-vf54g7rosfslk2ju1j2r54v3ta5l2tnh.apps.googleusercontent.com',
    iosBundleId: 'com.sharide.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCM4Psrtp1Mpq2mg0cuTXZJRLe-XPmK_fk',
    appId: '1:643037091126:web:da568e61aa291eb20f8f97',
    messagingSenderId: '643037091126',
    projectId: 'sharide-app',
    authDomain: 'sharide-app.firebaseapp.com',
    storageBucket: 'sharide-app.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBfW7WslVnfCW0rJD8wMvqbVW7fGwtBkUY',
    appId: '1:643037091126:ios:6f719ee414e278240f8f97',
    messagingSenderId: '643037091126',
    projectId: 'sharide-app',
    storageBucket: 'sharide-app.appspot.com',
    androidClientId: '643037091126-9ai14t3pf3sa7q915v2g996gn8l7h6dm.apps.googleusercontent.com',
    iosClientId: '643037091126-4dc90rlpe8q5ba23475soc41kolceat4.apps.googleusercontent.com',
    iosBundleId: 'com.sharide.sharide',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCM4Psrtp1Mpq2mg0cuTXZJRLe-XPmK_fk',
    appId: '1:643037091126:web:9a120039134d3fe70f8f97',
    messagingSenderId: '643037091126',
    projectId: 'sharide-app',
    authDomain: 'sharide-app.firebaseapp.com',
    storageBucket: 'sharide-app.appspot.com',
  );

}