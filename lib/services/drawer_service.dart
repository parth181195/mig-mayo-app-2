import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/core/app.router.dart';
import 'package:mig_mayo/models/orderDataCountModel.dart';
import 'package:mig_mayo/models/orderDataCountModel.dart';
import 'package:mig_mayo/models/order_status.dart';
import 'package:mig_mayo/ui/widgets/order_card.dart';
import 'package:stacked_services/stacked_services.dart';

class DrawerService {
  NavigationService _navigationService = locator<NavigationService>();
  StreamController<dynamic> drawerSubject =
      StreamController<dynamic>.broadcast();
  StreamController<OrderStatus> activeOrderStatus =
      StreamController<OrderStatus>.broadcast();
  StreamController<OrderDataCountModel> activeOrderData =
      StreamController<OrderDataCountModel>.broadcast();


  navigateTo(String routeName,
      {dynamic arguments,
      int? id,
      bool preventDuplicates = true,
      Map<String, String>? parameters}) {
    this._navigationService.navigateTo(routeName,
        arguments: arguments,
        id: id,
        parameters: parameters,
        preventDuplicates: preventDuplicates);
  }

  goToOrderPage(OrderStatus orderStatus) {
    if (this._navigationService.currentRoute != Routes.homeView &&
        this._navigationService.currentRoute != '') {
      this
          ._navigationService
          .navigateTo(Routes.homeView, arguments: {'status': orderStatus});
    }
    this.activeOrderStatus.sink.add(orderStatus);
    this._navigationService.popRepeated(1);
  }
}
