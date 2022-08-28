import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:mig_mayo/core/app.locator.dart';
import 'package:mig_mayo/core/app.router.dart';
import 'package:mig_mayo/firebase_options.dart';
import 'package:mig_mayo/services/firebase_service.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:stacked_services/stacked_services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {}
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RootPage();
  }
}

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
        child: MaterialApp(
      navigatorKey: StackedService.navigatorKey,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [StackedService.routeObserver],
      title: 'Mig Mayo',
      onGenerateRoute: StackedRouter().onGenerateRoute,
    ));
  }
}
