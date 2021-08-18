import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/core/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();

  onInit() async {
    Future.delayed(Duration(seconds: 2), () {
      _navigationService.clearStackAndShow(Routes.loginView);
    });
  }
}
