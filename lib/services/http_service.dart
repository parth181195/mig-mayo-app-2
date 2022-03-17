import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as _dio;
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/core/app.router.dart';
import 'package:mig_mayo/models/addOrderModel.dart';
import 'package:mig_mayo/models/orderSetStatusModel.dart';
import 'package:mig_mayo/utils/constants.dart';
import 'package:stacked_services/stacked_services.dart';
import 'auth_service.dart';

class HttpService {
  Dio dio = Dio();
  AuthService _authService = locator<AuthService>();
  NavigationService _navigationService = locator<NavigationService>();
  List<dynamic> vendorList = [];

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

  initInterceptors() {
    String _token = _authService.readExistingToken();
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers = {'Authorization': _token};
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (DioError e, handler) async {
      if (e.response?.statusCode == 401) {
        dio.lock();
        dio.interceptors.errorLock.lock();
        bool tokenRes = await _authService.refreshToken();
        if (tokenRes) {
          RequestOptions? options = e.response?.requestOptions;
          options?.headers = {
            'Authorization': _authService.readExistingToken()
          };
          var res = await dio.fetch(options!);
          dio.unlock();
          dio.interceptors.errorLock.unlock();
          print(res);
          handler.resolve(res);
        } else {
          dio.interceptors.requestLock.unlock();
          _navigationService.clearStackAndShow(Routes.loginView);
        }
      } else {
        return handler.next(e);
      }
    }));

    dio.interceptors.add(DioLogInterceptor());
  }
}
