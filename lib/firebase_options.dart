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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCsevdsxZRAQO2Fy4Iw9qcFGRaBDwfUuQ',
    appId: '1:5511230237:android:b4d232686e6c19ba4427f4',
    messagingSenderId: '5511230237',
    projectId: 'project3-a4d8f',
    storageBucket: 'project3-a4d8f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJERUPS5H8vcTSBvfBBppVR2Gu3ylPbio',
    appId: '1:5511230237:ios:ace857e8fb152bf54427f4',
    messagingSenderId: '5511230237',
    projectId: 'project3-a4d8f',
    storageBucket: 'project3-a4d8f.firebasestorage.app',
    iosBundleId: 'com.example.project3',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCxzjrS8PXiUW94_gFUpHCXy2dA3Ky127Q',
    appId: '1:5511230237:web:26e4cfffd3fbaa814427f4',
    messagingSenderId: '5511230237',
    projectId: 'project3-a4d8f',
    authDomain: 'project3-a4d8f.firebaseapp.com',
    storageBucket: 'project3-a4d8f.firebasestorage.app',
  );

}