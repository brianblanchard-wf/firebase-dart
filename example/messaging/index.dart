library firebase.example.auth;

import 'dart:html';

import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/src/assets/assets.dart';

main() async {
  //Use for firebase package development only
  await config();

  fb.initializeApp(
      apiKey: apiKey,
      authDomain: authDomain,
      databaseURL: databaseUrl,
      storageBucket: storageBucket,
      messagingSenderId: messagingSenderId);

  var messaging = fb.messaging();

  try {
    await messaging.requestPermission();

    String token = await messaging.getToken();

    messaging.onMessage.listen((payload) => print(payload));

  } catch (e) {
    print(e);
  }

}
