import 'package:flutter/cupertino.dart';
import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/core/app.router.dart';
import 'package:mig_mayo/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  AuthService _authService = locator<AuthService>();
  bool showPassword = false;
  TextEditingController emailTextEditingController = new TextEditingController(text: '1972vragrawal@gmail.com');
  TextEditingController passwordTextEditingController = new TextEditingController(text: 'Samrat@123');

  login() async {
    setBusyForObject('login', true);
    bool response = await _authService.login(
      emailTextEditingController.value.text,
      passwordTextEditingController.value.text,
    );
    if (response) {
      setBusyForObject('login', false);
      _navigationService.clearStackAndShow(
        Routes.homeView,
      );
    } else {
      setBusyForObject('login', false);
    }
  }

  goToForgotPassword() {
    _navigationService.navigateTo(Routes.forgotPasswordView);
  }

  togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }
}
