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
    apiKey: 'AIzaSyC9KdTpDmlHjlm4ULqWHPXjoeg-B31Srlc',
    appId: '1:144087426142:web:881c418099e860c43300cf',
    messagingSenderId: '144087426142',
    projectId: 'invoice-project-55737',
    authDomain: 'invoice-project-55737.firebaseapp.com',
    storageBucket: 'invoice-project-55737.firebasestorage.app',
    measurementId: 'G-29RH2ZWZTZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCI1lufW5D4fgTu-gIAfqu6fcL_oYml0H8',
    appId: '1:144087426142:android:79c32101315b39ca3300cf',
    messagingSenderId: '144087426142',
    projectId: 'invoice-project-55737',
    storageBucket: 'invoice-project-55737.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-3AxyEi0uKUweHZ83abPGsrJydGdRpfw',
    appId: '1:144087426142:ios:de4992bedc99f8913300cf',
    messagingSenderId: '144087426142',
    projectId: 'invoice-project-55737',
    storageBucket: 'invoice-project-55737.firebasestorage.app',
    androidClientId: '144087426142-f09t1hk15ok84tpq8q687vc7spdmtnt5.apps.googleusercontent.com',
    iosClientId: '144087426142-atns3lipcg0eve5fudu06dqp5vjj6rbc.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterInvoiceApp',
  );
}
