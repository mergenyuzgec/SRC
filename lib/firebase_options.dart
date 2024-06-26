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
    apiKey: 'AIzaSyBHXoc74gWa-7CmdyLzNU-4OG8SZ4Kbk1k',
    appId: '1:682266962440:web:22c2e632fbd17557fd7fbd',
    messagingSenderId: '682266962440',
    projectId: 'sosyal-surucu',
    authDomain: 'sosyal-surucu.firebaseapp.com',
    databaseURL: 'https://sosyal-surucu-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'sosyal-surucu.appspot.com',
    measurementId: 'G-135PGJNJ1H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZC7vGZgl5ImfD8qE02-gA-e8qcOz9up0',
    appId: '1:682266962440:android:12e9f46ab450c3b4fd7fbd',
    messagingSenderId: '682266962440',
    projectId: 'sosyal-surucu',
    databaseURL: 'https://sosyal-surucu-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'sosyal-surucu.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCWV3YlYlYwdZR6a7jrPjzpqTLW3_VwDFA',
    appId: '1:682266962440:ios:27cc44f64cf6313dfd7fbd',
    messagingSenderId: '682266962440',
    projectId: 'sosyal-surucu',
    databaseURL: 'https://sosyal-surucu-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'sosyal-surucu.appspot.com',
    androidClientId: '682266962440-m3e8o7vdf7l6l3eh16d6njj2g5fo26e2.apps.googleusercontent.com',
    iosClientId: '682266962440-ntpceqgh16r6357j3sm5mbestucr8ffq.apps.googleusercontent.com',
    iosBundleId: 'com.example.sosyalSurucu',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCWV3YlYlYwdZR6a7jrPjzpqTLW3_VwDFA',
    appId: '1:682266962440:ios:27cc44f64cf6313dfd7fbd',
    messagingSenderId: '682266962440',
    projectId: 'sosyal-surucu',
    databaseURL: 'https://sosyal-surucu-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'sosyal-surucu.appspot.com',
    androidClientId: '682266962440-m3e8o7vdf7l6l3eh16d6njj2g5fo26e2.apps.googleusercontent.com',
    iosClientId: '682266962440-ntpceqgh16r6357j3sm5mbestucr8ffq.apps.googleusercontent.com',
    iosBundleId: 'com.example.sosyalSurucu',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBHXoc74gWa-7CmdyLzNU-4OG8SZ4Kbk1k',
    appId: '1:682266962440:web:94e68f328809d98ffd7fbd',
    messagingSenderId: '682266962440',
    projectId: 'sosyal-surucu',
    authDomain: 'sosyal-surucu.firebaseapp.com',
    databaseURL: 'https://sosyal-surucu-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'sosyal-surucu.appspot.com',
    measurementId: 'G-Q0R2GL252E',
  );
}
