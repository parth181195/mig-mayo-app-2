import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/models/dailyBusinessModel.dart';
import 'package:mig_mayo/services/drawer_service.dart';
import 'package:mig_mayo/services/http_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DrawerViewModel extends BaseViewModel {
  DrawerService drawerService = locator<DrawerService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  NavigationService _navigationService = locator<NavigationService>();
  HttpService _httpService = locator<HttpService>();

  DateTimeRange selectedDate =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  late DailyBusinessModel dailyBusinessData = DailyBusinessModel();

  init() async {
    await getDailyBusiness();
  }

  getDailyBusiness() async {
    _httpService.getDailyBusiness(selectedDate).then((value) {
      setBusyForObject('dailyBusiness', false);
      notifyListeners();
      if (value?.data != null) {
        dailyBusinessData =
            DailyBusinessModel.fromJson(jsonDecode(value?.data));
        setBusyForObject('dailyBusiness', false);
        notifyListeners();
      }
    }, onError: (e) {
      setBusyForObject('dailyBusiness', false);
      notifyListeners();
    });
  }
}
