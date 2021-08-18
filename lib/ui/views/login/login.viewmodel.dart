import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/core/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();

  login() {
    setBusyForObject('login', true);
    Future.delayed(Duration(seconds: 2), () {
      setBusyForObject('login', false);
      _navigationService.clearStackAndShow(Routes.loginView);
    });
  }

  goToForgotPassword() {
    _navigationService.navigateTo(Routes.forgotPasswordView);
  }
}
