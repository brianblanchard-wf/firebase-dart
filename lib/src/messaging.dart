import 'dart:async';

import 'package:js/js.dart';

import 'interop/messaging_interop.dart' as messaging_interop;
import 'utils.dart';
import 'js.dart';

class Messaging extends JsObjectWrapper<messaging_interop.MessagingJsImpl> {
  Messaging.fromJsObject(messaging_interop.MessagingJsImpl jsObject)
      : super.fromJsObject(jsObject);

  var _onMessageUnsubscribe;
  StreamController<Map> _onMessageController;

  var _onTokenUnsubscribe;
  StreamController _onTokenRefreshController;

  Future deleteToken() => handleThenable(jsObject.deleteToken());

  Future<String> getToken() => handleThenable(jsObject.getToken());

  Stream<Map> get onMessage {
    if (_onMessageController == null) {
      var nextWrapper = allowInterop((payload) => _onMessageController.add(payload));

      void startListen() {
        _onMessageUnsubscribe = jsObject.onMessage(nextWrapper);
      }

      void stopListen() {
        if (_onMessageUnsubscribe != null) {
          _onMessageUnsubscribe();
        }
      }

      _onMessageController = new StreamController.broadcast(onListen: startListen,
          onCancel: stopListen, sync: true);
    }

    return _onMessageController.stream;
  }

  Stream onTokenRefresh() {
    if (_onTokenRefreshController == null) {
      var nextWrapper = allowInterop(() => _onTokenRefreshController.add(null));

      void startListen() {
        _onTokenUnsubscribe = jsObject.onTokenRefresh(nextWrapper);
      }

      void stopListen() {
        if (_onTokenUnsubscribe != null) {
          _onTokenUnsubscribe();
        }
      }

      _onTokenRefreshController = new StreamController.broadcast(
          onListen: startListen, onCancel: stopListen, sync: true);
    }

    return _onTokenRefreshController.stream;
  }

  Future requestPermission() => handleThenable(jsObject.requestPermission());
}
