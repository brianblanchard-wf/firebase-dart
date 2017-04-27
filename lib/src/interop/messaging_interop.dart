@JS('firebase.messaging')
library firebase.messaging_interop;

import 'package:func/func.dart';
import 'package:js/js.dart';

import 'firebase_interop.dart';

@JS('Messaging')
abstract class MessagingJsImpl {
  external PromiseJsImpl deleteToken();
  external PromiseJsImpl<String> getToken();
  external Func0 onMessage(onOrNextObserver);
  external Func0 onTokenRefresh(onOrNextObserver);
  external PromiseJsImpl requestPermission();
  external void setBackgroundMessageHandler(callback);
  // TODO: useServiceWorker
}
