import 'package:ink_page_indicator/ink_page_indicator.dart';
import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/core/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  int dotCount = 3;
  int activeStep = 1;
  PageIndicatorController controller = PageIndicatorController();

  nextStep() {
    activeStep = activeStep == 3 ? 3 : activeStep + 1;
  }

  previousStep() {
    activeStep = activeStep == 1 ? 1 : activeStep - 1;
  }

  login() {
    setBusyForObject('login', true);
    Future.delayed(Duration(seconds: 2), () {
      setBusyForObject('login', false);
      _navigationService.clearStackAndShow(Routes.loginView);
    });
  }
}
