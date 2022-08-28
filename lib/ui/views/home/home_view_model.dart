import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/core/app.router.dart';
import 'package:mig_mayo/models/deliveryExecutiveModel.dart';
import 'package:mig_mayo/models/dropDownModel.dart';
import 'package:mig_mayo/models/orderDataCountModel.dart';
import 'package:mig_mayo/models/orderSetStatusModel.dart';
import 'package:mig_mayo/models/order_model.dart';
import 'package:mig_mayo/models/order_status.dart';
import 'package:mig_mayo/models/setOrderStatusResponseModel.dart';
import 'package:mig_mayo/services/drawer_service.dart';
import 'package:mig_mayo/services/firebase_service.dart';
import 'package:mig_mayo/services/http_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  bool registeredToSink = false;
  FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  DrawerService drawerService = locator<DrawerService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  FirebaseService _firebaseService = locator<FirebaseService>();
  NavigationService _navigationService = locator<NavigationService>();
  TextEditingController remarkTextEditingController = TextEditingController();
  late StreamSubscription routeSub;
  late TabController tabController;
  List<DeliveryExecutiveModel> deliveryExecutiveData = [];
  List<DropDownModel> dropdownItemList = [
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

  List<String> pages = [
    'all',
    'active',
    'confirmed',
    'cancelled',
    'delivered',
    'unDelivered',
    'pending',
  ];
  Map<String, List<OrderModel>> orders = {
    'all': [],
    'active': [],
    'confirmed': [],
    'cancelled': [],
    'delivered': [],
    'unDelivered': [],
    'pending': [],
  };

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

  getOrderLocation(OrderStatus status) {
    switch (status) {
      case OrderStatus.Active:
        return 'active';
      case OrderStatus.Confirmed:
        return 'confirmed';
      case OrderStatus.Cancelled:
        return 'cancelled';
      case OrderStatus.Delivered:
        return 'delivered';
      case OrderStatus.Undelivered:
        return 'unDelivered';
      case OrderStatus.Pending:
        return 'pending';
    }
  }

  late StreamSubscription<OrderStatus> orderStatusSub;
  HttpService _httpService = locator<HttpService>();

  init(TabController controller) async {
    if (!registeredToSink) {
      _firebaseService.refreshOrders.stream.listen((event) {
        init(tabController);
        registeredToSink = true;
      });
    }
    _secureStorage.deleteAll();
    _snackbarService.registerSnackbarConfig(SnackbarConfig(
      backgroundColor: Colors.black,
      textColor: Colors.white,
      titleColor: Colors.white,
      messageColor: Colors.white,
      mainButtonTextColor: Colors.black,
    ));
    pages.forEach((element) {
      orders[element] = [];
      setBusyForObject(element, true);
    });
    notifyListeners();
    this.tabController = controller;
    if (this._navigationService.currentArguments != null) {
      if ((this._navigationService.currentArguments.order.status) != null) {
        this.tabController.animateTo(((this
                ._navigationService
                .currentArguments
                .order
                .status) as OrderStatus)
            .index);
      }
    } else {
      this.tabController.animateTo(0);
    }
    tabController.addListener(() {
      notifyListeners();
    });
    subToDrawer();
    this.tabController.addListener(() {});
    _httpService.getAllOrderData().then((value) {
      (jsonDecode(value?.data) as List<dynamic>).forEach((order) {
        (orders['all'] as List<OrderModel>).add(OrderModel.fromJson(order));
        setBusyForObject('all', false);
      });
      Future.wait([
        _httpService.getActiveOrderData(),
        _httpService.getCancelledOrderData(),
        _httpService.getDeliveredOrderData(),
        _httpService.getUnDeliveredOrderData(),
        _httpService.getPendingOrderData()
      ]).then((value) async {
        value.asMap().forEach((index, element) {
          if (element != null && element.data != '') {
            (jsonDecode(element.data) as List<dynamic>).forEach((order) {
              OrderModel orderData = OrderModel.fromJson(order);
              if (orderData.status == OrderStatus.Active) {
                (orders['active'] as List<OrderModel>)
                    .add(OrderModel.fromJson(order));
                setBusyForObject('active', false);
              } else if (orderData.status == OrderStatus.Confirmed) {
                (orders['confirmed'] as List<OrderModel>)
                    .add(OrderModel.fromJson(order));
                setBusyForObject('confirmed', false);
              } else if (orderData.status == OrderStatus.Cancelled) {
                (orders['cancelled'] as List<OrderModel>)
                    .add(OrderModel.fromJson(order));
                setBusyForObject('cancelled', false);
              } else if (orderData.status == OrderStatus.Delivered) {
                (orders['delivered'] as List<OrderModel>)
                    .add(OrderModel.fromJson(order));
                setBusyForObject('delivered', false);
              } else if (orderData.status == OrderStatus.Undelivered) {
                (orders['unDelivered'] as List<OrderModel>)
                    .add(OrderModel.fromJson(order));
              } else if (orderData.status == OrderStatus.Pending) {
                (orders['pending'] as List<OrderModel>)
                    .add(OrderModel.fromJson(order));
                setBusyForObject('pending', false);
              }
              setBusyForObject('unDelivered', false);
            });
          }
          publishCount();
          if (orders['all']?.length == 0) {
            setBusyForObject('all', false);
          }
          if (orders['active']?.length == 0) {
            setBusyForObject('active', false);
          }
          if (orders['confirmed']?.length == 0) {
            setBusyForObject('confirmed', false);
          }
          if (orders['cancelled']?.length == 0) {
            setBusyForObject('cancelled', false);
          }
          if (orders['delivered']?.length == 0) {
            setBusyForObject('delivered', false);
          }
          if (orders['unDelivered']?.length == 0) {
            setBusyForObject('unDelivered', false);
          }
          if (orders['pending']?.length == 0) {
            setBusyForObject('pending', false);
          }
          setBusyForObject('unDelivered', false);
          notifyListeners();
        });
        _httpService.getDeliveryExecutivesData().then((value) {
          deliveryExecutiveData = [];
          (jsonDecode(value?.data) as List<dynamic>)
              .forEach((deliveryExecutive) {
            deliveryExecutiveData
                .add(DeliveryExecutiveModel.fromJson(deliveryExecutive));
          });
          notifyListeners();
        });
        await _firebaseService.registerToken();
        await _firebaseService.initMessages();
      });
    });
  }

  setOrderStatus(OrderModel order, OrderSetStatusModel payload, fn) async {
    setBusyForObject('setStatus', true);
    OrderModel? selectedOrder = orders[getOrderLocation(order.status!)]
        ?.firstWhere((element) => element.alphaId == order.alphaId);
    notifyListeners();
    fn(() {});
    _httpService.setOrderStatus(payload).then((value) {
      order.status = getStatusEnum(payload.status!);
      order.orderStatusRemarks = payload.orderStatusRemarks;
      orders[getOrderLocation(getStatusEnum(payload.status!))]!
          .remove(selectedOrder);
      orders[getOrderLocation(getStatusEnum(payload.status!))]!.add(order);
      setBusyForObject('setStatus', false);
      _navigationService.popRepeated(1);
      notifyListeners();
      publishCount();
      fn(() {});
    });
  }

  publishCount() {
    OrderDataCountModel orderCountData = OrderDataCountModel(
      all: orders['all']?.length ?? 0,
      active: orders['active']?.length ?? 0,
      confirmed: orders['confirmed']?.length ?? 0,
      cancelled: orders['cancelled']?.length ?? 0,
      delivered: orders['delivered']?.length ?? 0,
      unDelivered: orders['unDelivered']?.length ?? 0,
      pending: orders['pending']?.length ?? 0,
    );
    drawerService.activeOrderData.sink.add(orderCountData);
  }

  setOrderConfirm(OrderModel order) {
    OrderSetStatusModel payload = OrderSetStatusModel(
        status: getStatusText(OrderStatus.Confirmed), alphaId: order.alphaId);
    return _httpService.setOrderStatus(payload).then((value) {
      SetOrderStatusResponseModel res =
          SetOrderStatusResponseModel.fromJson(value?.data);
      if (res.status ?? false) {
        OrderModel? selectedOrder = orders[pages[this.tabController.index]]
            ?.firstWhere((element) => element.alphaId == order.alphaId);
        selectedOrder?.status = OrderStatus.Confirmed;
        orders['confirmed']?.add(selectedOrder!);
        orders['active']?.remove(selectedOrder);

        _snackbarService.showSnackbar(
            message: 'Order Confirmed', title: 'Order Status Changed');
        notifyListeners();
        publishCount();
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
        OrderModel? selectedOrder = orders[pages[this.tabController.index]]
            ?.firstWhere((element) => element.alphaId == order.alphaId);
        selectedOrder?.status = OrderStatus.Cancelled;
        orders['cancelled']?.add(selectedOrder!);
        orders['active']?.remove(selectedOrder);

        notifyListeners();
        _snackbarService.showSnackbar(
            message: 'Order Cancelled', title: 'Order Status Changed');
        publishCount();
      }
    }).catchError((e) {
      print(e);
    });
  }

  subToDrawer() {
    routeSub = drawerService.drawerSubject.stream.listen((event) {});
    orderStatusSub = drawerService.activeOrderStatus.stream.listen((event) {
      this.tabController.animateTo(event.index);
    });
  }

  goToOrderDetails(OrderModel order) {
    this._navigationService.navigateTo(Routes.ordersView,
        arguments: OrdersViewArguments(order: order));
  }

  goToAddOrder() {
    this._navigationService.navigateTo(Routes.addOrderView);
  }
}
