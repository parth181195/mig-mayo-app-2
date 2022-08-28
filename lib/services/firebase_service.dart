import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/models/order_model.dart';
import 'package:mig_mayo/models/token_sync_model.dart';
import 'package:mig_mayo/services/auth_service.dart';
import 'package:mig_mayo/services/http_service.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {
  HttpService _httpService = locator<HttpService>();
  Uuid uuid = Uuid();
  StreamController<dynamic> refreshOrders =
      StreamController<dynamic>.broadcast();

  getPermission() {
    FirebaseMessaging.instance.requestPermission().then((value) {
      print(value);
    });
  }

  registerToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    TokenSyncModel payload =
        TokenSyncModel(uuid: uuid.v4(), deviceToken: token, type: 'mobile');
    await this._httpService.syncToken(payload);
  }

  initMessages() async {
    try {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        this
            .refreshOrders
            .sink
            .add(OrderModel.fromJson(jsonDecode(message.data['body'])));
        showSimpleNotification(
          Text(message.data['title']),
          background: Colors.green,
          elevation: 0,
        );
        if (message.notification != null) {}
      });
    } catch (e) {
      print(e);
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print("Handling a background message: ${message.messageId}");
}
