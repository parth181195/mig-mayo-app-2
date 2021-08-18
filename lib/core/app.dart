import 'package:mig_mayo/ui/views/forgotPassword/forgotPassword.view.dart';
import 'package:mig_mayo/ui/views/login/login.view.dart';
import 'package:mig_mayo/ui/views/splash/splash.view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: SplashView, initial: true),
  MaterialRoute(
    page: LoginView,
  ),
  MaterialRoute(
    page: ForgotPasswordView,
  ),
], dependencies: [
  LazySingleton(classType: NavigationService),
])
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
