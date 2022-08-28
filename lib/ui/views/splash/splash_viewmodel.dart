import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/core/app.router.dart';
import 'package:mig_mayo/services/auth_service.dart';
import 'package:mig_mayo/services/firebase_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  AuthService _authService = locator<AuthService>();
  FirebaseService _firebaseService = locator<FirebaseService>();

  onInit() async {
    bool tokenExists = (await _authService.readToken()) != null;
    if (tokenExists) {
      await _authService.readRefreshToken();
      _navigationService.clearStackAndShow(Routes.homeView);
    } else {
      _navigationService.clearStackAndShow(Routes.loginView);
    }
  }
}
