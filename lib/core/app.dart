import 'package:mig_mayo/services/auth_service.dart';
import 'package:mig_mayo/services/drawer_service.dart';
import 'package:mig_mayo/services/firebase_service.dart';
import 'package:mig_mayo/services/http_service.dart';
import 'package:mig_mayo/ui/views/add_order/add_order_view.dart';
import 'package:mig_mayo/ui/views/forgotPassword/forgotPassword.view.dart';
import 'package:mig_mayo/ui/views/home/home_view.dart';
import 'package:mig_mayo/ui/views/login/login_view.dart';
import 'package:mig_mayo/ui/views/orders/orders_view.dart';
import 'package:mig_mayo/ui/views/splash/splash_view.dart';
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
  MaterialRoute(
    page: OrdersView,
  ),
  MaterialRoute(
      page: HomeView, maintainState: false
  ),
  MaterialRoute(
    page: AddOrderView,
  ),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: DrawerService),
  LazySingleton(classType: AuthService),
  LazySingleton(classType: HttpService),
  LazySingleton(classType: SnackbarService),
  LazySingleton(classType: FirebaseService),

])
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
