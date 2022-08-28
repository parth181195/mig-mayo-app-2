import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as _dio;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/core/app.router.dart';
import 'package:mig_mayo/models/addOrderModel.dart';
import 'package:mig_mayo/models/orderSetStatusModel.dart';
import 'package:mig_mayo/models/token_sync_model.dart';
import 'package:mig_mayo/utils/constants.dart';
import 'package:stacked_services/stacked_services.dart';
import 'auth_service.dart';

class HttpService {
  Dio tokenDio = Dio();
  Dio dio = Dio();
  AuthService _authService = locator<AuthService>();
  NavigationService _navigationService = locator<NavigationService>();
  List<dynamic> vendorList = [];

  // get authService => _authService;

  HttpService() {
    initInterceptors();
  }

  getStatusCheck() async {
    var res = await dio.get(URLConstants.vendorList);
    print(res);
  }

  getVendorData() async {
    try {
      vendorList = jsonDecode((await dio.get(URLConstants.vendorList)).data)
          as List<dynamic>;
      print(vendorList);
      return vendorList;
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<_dio.Response?> getAllOrderData() async {
    try {
      return dio.get(URLConstants.allOrders);
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<_dio.Response?> getDailyBusiness(DateTimeRange dateTimeRange) async {
    try {
      return dio.get(URLConstants.fetchDailyBusiness, queryParameters: {
        'firstDate': DateFormat('yyyy-MM-dd').format(dateTimeRange.start),
        'lastDate': DateFormat('yyyy-MM-dd').format(dateTimeRange.end)
      });
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<_dio.Response?> addOrderData(AddOrderModel orderModel) async {
    orderModel.deliveryDateTime =
        DateTime.parse(orderModel.deliveryDateTime!).toUtc().toIso8601String();
    try {
      return dio.post(URLConstants.manualOrder, data: orderModel);
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<_dio.Response?> getMenuData() async {
    try {
      return dio.get(URLConstants.fetchMenu);
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<_dio.Response?> getMenuItemData() async {
    try {
      return dio.get(URLConstants.fetchItems);
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<_dio.Response?> getActiveOrderData() async {
    try {
      return dio.get(URLConstants.activeOrders);
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<_dio.Response?> setOrderStatus(OrderSetStatusModel payload) async {
    try {
      return dio.put(URLConstants.setOrdersStatus, data: payload.toJson());
    } catch (e) {
      print(e);
      return Future.value(null);
    }
  }

  Future<_dio.Response?> getCancelledOrderData() async {
    try {
      return dio.get(URLConstants.cancelledOrders);
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<_dio.Response?> getDeliveredOrderData() async {
    try {
      return dio.get(URLConstants.deliveredOrders);
    } catch (e) {
      return Future.value();
    }
  }

  Future<_dio.Response?> getUnDeliveredOrderData() async {
    try {
      return dio.get(URLConstants.unDeliveredOrders);
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<_dio.Response?> getPendingOrderData() async {
    try {
      return dio.get(URLConstants.pendingOrders);
    } catch (e) {
      print(e);
      return Future.value(null);
    }
  }

  Future<_dio.Response?> getNewOrderId() async {
    // fetch_delivery_executives_stats
    try {
      return dio.get(URLConstants.generateOrderId);
    } catch (e) {
      print(e);
      return Future.value(null);
    }
  }

  Future<_dio.Response?> getDeliveryExecutivesData() async {
    // fetch_delivery_executives_stats
    try {
      return dio.get(URLConstants.getDeliveryExecutivesDataOrder);
    } catch (e) {
      print(e);
      return Future.value(null);
    }
  }

  syncToken(TokenSyncModel payload) {
    try {
      return dio.post(URLConstants.deviceToken, data: payload);
    } catch (e) {
      print(e);
      return Future.value(null);
    }
  }

  initInterceptors() async {
    String? _token = await _authService.readToken();
    print('got token ');
    print(_token);
    if (_token == null) {
      _token = '';
    }
    dio.interceptors
        .add(_dio.QueuedInterceptorsWrapper(onRequest: (options, handler) {
      options.headers = {'Authorization': _token};
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (DioError e, handler) async {
      if (e.response?.statusCode == 401) {
        String? tokenRes = await _authService.refreshToken()!;
        if (tokenRes != null) {
          RequestOptions? options = e.response?.requestOptions;
          options?.headers = {'Authorization': tokenRes};
          try {
            handler.resolve(await tokenDio.fetch(options!));
          } catch (e) {
            print(e);
            _navigationService.clearStackAndShow(Routes.loginView);
          }
        } else {
          _navigationService.clearStackAndShow(Routes.loginView);
        }
      } else {
        return handler.next(e);
      }
    }));
  }
}
