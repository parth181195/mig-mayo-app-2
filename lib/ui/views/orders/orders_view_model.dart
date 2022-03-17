import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/core/app.router.dart';
import 'package:mig_mayo/models/deliveryExecutiveModel.dart';
import 'package:mig_mayo/models/dropDownModel.dart';
import 'package:mig_mayo/models/orderSetStatusModel.dart';
import 'package:mig_mayo/models/order_model.dart';
import 'package:mig_mayo/models/order_status.dart';
import 'package:mig_mayo/models/setOrderStatusResponseModel.dart';
import 'package:mig_mayo/services/drawer_service.dart';
import 'package:mig_mayo/services/http_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OrdersViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  HttpService _httpService = locator<HttpService>();
  SnackbarService _snackbarService = locator<SnackbarService>();

  List<DeliveryExecutiveModel> deliveryExecutiveData = [];
  List<DropDownModel> dropdownItemList = [
    DropDownModel<OrderStatus>(label: 'Active', value: OrderStatus.Active),
    DropDownModel<OrderStatus>(
        label: 'Confirmed', value: OrderStatus.Confirmed),
    DropDownModel<OrderStatus>(
        label: 'Cancelled', value: OrderStatus.Cancelled),
    DropDownModel<OrderStatus>(
        label: 'Delivered', value: OrderStatus.Delivered),
    DropDownModel<OrderStatus>(
        label: 'UnDelivered', value: OrderStatus.Undelivered),
    DropDownModel<OrderStatus>(label: 'Pending', value: OrderStatus.Pending),
  ];

  onInit() async {
    _httpService.getDeliveryExecutivesData().then((value) {
      deliveryExecutiveData = [];
      (jsonDecode(value?.data) as List<dynamic>).forEach((deliveryExecutive) {
        deliveryExecutiveData
            .add(DeliveryExecutiveModel.fromJson(deliveryExecutive));
      });
      notifyListeners();
    });
  }

  getStatusEnum(String status) {
    switch (status) {
      case 'Active':
        return OrderStatus.Active;
      case 'Confirmed':
        return OrderStatus.Confirmed;
      case 'Cancelled':
        return OrderStatus.Cancelled;
      case 'Delivered':
        return OrderStatus.Delivered;
      case 'UnDelivered':
        return OrderStatus.Undelivered;
      case 'Pending':
        return OrderStatus.Pending;
    }
  }

  getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.Active:
        return 'Active';
      case OrderStatus.Confirmed:
        return 'Confirmed';
      case OrderStatus.Cancelled:
        return 'Cancelled';
      case OrderStatus.Delivered:
        return 'Delivered';
      case OrderStatus.Undelivered:
        return 'UnDelivered';
      case OrderStatus.Pending:
        return 'Pending';
    }
  }

  setOrderStatus(OrderModel order, OrderSetStatusModel payload, fn) async {
    setBusyForObject('setStatus', true);
    notifyListeners();
    fn(() {});
    _httpService.setOrderStatus(payload).then((value) {
      order.status = getStatusEnum(payload.status!);
      order.orderStatusRemarks = payload.orderStatusRemarks;
      setBusyForObject('setStatus', false);
      _navigationService.popRepeated(1);
      notifyListeners();
      fn(() {});
    });
  }

  setOrderConfirm(OrderModel order) {
    OrderSetStatusModel payload = OrderSetStatusModel(
        status: getStatusText(OrderStatus.Confirmed), alphaId: order.alphaId);
    return _httpService.setOrderStatus(payload).then((value) {
      SetOrderStatusResponseModel res =
          SetOrderStatusResponseModel.fromJson(value?.data);
      if (res.status ?? false) {
        order.status = OrderStatus.Confirmed;
        _snackbarService.showSnackbar(
            message: 'Order Confirmed', title: 'Order Status Changed');
        notifyListeners();
      }
    });
  }

  setOrderCancel(OrderModel order) {
    OrderSetStatusModel payload = OrderSetStatusModel(
        status: getStatusText(OrderStatus.Cancelled), alphaId: order.alphaId);
    _httpService.setOrderStatus(payload).then((value) {
      SetOrderStatusResponseModel res =
          SetOrderStatusResponseModel.fromJson(value?.data);
      if (res.status ?? false) {
        order.status = OrderStatus.Cancelled;
        notifyListeners();
        _snackbarService.showSnackbar(
            message: 'Order Cancelled', title: 'Order Status Changed');
      }
    }).catchError((e) {
      print(e);
    });
  }
}
