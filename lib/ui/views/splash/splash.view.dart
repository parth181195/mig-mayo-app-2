import 'package:flutter/material.dart';
import 'package:mig_mayo/ui/views/splash/splash.viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
        viewModelBuilder: () => SplashViewModel(),
        onModelReady: (model) async => await model.onInit(),
        builder: (context, viewModel, child) => Scaffold(
              body: Center(
                child: Text('splash'),
              ),
            ));
  }
}
