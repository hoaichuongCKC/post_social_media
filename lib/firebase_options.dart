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
    apiKey: 'AIzaSyDUKvVOrKWhAFrjsdl-DRio2J4MsZyFlPo',
    appId: '1:180013964021:web:79ec2856bca39e73d103bc',
    messagingSenderId: '180013964021',
    projectId: 'post-app-27835',
    authDomain: 'post-app-27835.firebaseapp.com',
    storageBucket: 'post-app-27835.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3KYqIL8_xD-83bjBInZYIBcVjM_-seX4',
    appId: '1:180013964021:android:218758b33f317ff3d103bc',
    messagingSenderId: '180013964021',
    projectId: 'post-app-27835',
    storageBucket: 'post-app-27835.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlrc2cwaaIb2OBZHuxWvmq2KNoMp8zC-4',
    appId: '1:180013964021:ios:500be16cdcb2b37dd103bc',
    messagingSenderId: '180013964021',
    projectId: 'post-app-27835',
    storageBucket: 'post-app-27835.appspot.com',
    iosClientId:
        '180013964021-t78o7ar05cm2vj0a2rm8e2m6btp7frhc.apps.googleusercontent.com',
    iosBundleId: 'com.example.postMediaSocial',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDlrc2cwaaIb2OBZHuxWvmq2KNoMp8zC-4',
    appId: '1:180013964021:ios:500be16cdcb2b37dd103bc',
    messagingSenderId: '180013964021',
    projectId: 'post-app-27835',
    storageBucket: 'post-app-27835.appspot.com',
    iosClientId:
        '180013964021-t78o7ar05cm2vj0a2rm8e2m6btp7frhc.apps.googleusercontent.com',
    iosBundleId: 'com.example.postMediaSocial',
  );
}
