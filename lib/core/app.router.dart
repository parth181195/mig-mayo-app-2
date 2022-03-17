// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../models/order_model.dart';
import '../ui/views/add_order/add_order_view.dart';
import '../ui/views/forgotPassword/forgotPassword.view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/login/login_view.dart';
import '../ui/views/orders/orders_view.dart';
import '../ui/views/splash/splash_view.dart';

class Routes {
  static const String splashView = '/';
  static const String loginView = '/login-view';
  static const String forgotPasswordView = '/forgot-password-view';
  static const String ordersView = '/orders-view';
  static const String homeView = '/home-view';
  static const String addOrderView = '/add-order-view';
  static const all = <String>{
    splashView,
    loginView,
    forgotPasswordView,
    ordersView,
    homeView,
    addOrderView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.forgotPasswordView, page: ForgotPasswordView),
    RouteDef(Routes.ordersView, page: OrdersView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.addOrderView, page: AddOrderView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    ForgotPasswordView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ForgotPasswordView(),
        settings: data,
      );
    },
    OrdersView: (data) {
      var args = data.getArgs<OrdersViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => OrdersView(
          key: args.key,
          order: args.order,
        ),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    AddOrderView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddOrderView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// OrdersView arguments holder class
class OrdersViewArguments {
  final Key? key;
  final OrderModel order;
  OrdersViewArguments({this.key, required this.order});
}
