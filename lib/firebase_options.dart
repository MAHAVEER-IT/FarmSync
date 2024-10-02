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
    apiKey: 'AIzaSyCHVucISr1kn_aZI-K6vojBfK4L9sjU4Vk',
    appId: '1:657628802174:web:b3dbcaa63df4fdf62f3c2f',
    messagingSenderId: '657628802174',
    projectId: 'farmsync-51a75',
    authDomain: 'farmsync-51a75.firebaseapp.com',
    storageBucket: 'farmsync-51a75.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXWtkrkkcmwRrKlg6Vb6uSwdOu5xceiPw',
    appId: '1:657628802174:android:8711ecb1bfa29cbb2f3c2f',
    messagingSenderId: '657628802174',
    projectId: 'farmsync-51a75',
    storageBucket: 'farmsync-51a75.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4O3Mx7qt3Fh-hAYFK0ucjH6-wFlXtIUw',
    appId: '1:657628802174:ios:51a2aac0e403183f2f3c2f',
    messagingSenderId: '657628802174',
    projectId: 'farmsync-51a75',
    storageBucket: 'farmsync-51a75.appspot.com',
    iosBundleId: 'com.example.farmsync',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4O3Mx7qt3Fh-hAYFK0ucjH6-wFlXtIUw',
    appId: '1:657628802174:ios:51a2aac0e403183f2f3c2f',
    messagingSenderId: '657628802174',
    projectId: 'farmsync-51a75',
    storageBucket: 'farmsync-51a75.appspot.com',
    iosBundleId: 'com.example.farmsync',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCHVucISr1kn_aZI-K6vojBfK4L9sjU4Vk',
    appId: '1:657628802174:web:5186af8ecdd49c3b2f3c2f',
    messagingSenderId: '657628802174',
    projectId: 'farmsync-51a75',
    authDomain: 'farmsync-51a75.firebaseapp.com',
    storageBucket: 'farmsync-51a75.appspot.com',
  );
}
