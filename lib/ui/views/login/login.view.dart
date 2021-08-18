import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mig_mayo/ui/views/login/login.viewmodel.dart';
import 'package:mig_ui/mig_ui.dart';
import 'package:mig_ui/mig_ui.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, viewModel, child) => Scaffold(
                body: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Image.asset(
                    'assets/images/login_bg.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: kToolbarHeight, left: 20),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Food',
                                style: heading2Style.copyWith(fontSize: 45),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2, left: 20),
                              ),
                              Text(
                                'Logistics Made Easy',
                                style: heading3Style,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.02), offset: Offset(0, -2.2), blurRadius: 50),
                      BoxShadow(color: Colors.black.withOpacity(0.028), offset: Offset(0, -5.2), blurRadius: 50),
                      BoxShadow(color: Colors.black.withOpacity(0.035), offset: Offset(0, -10.0), blurRadius: 50),
                      BoxShadow(color: Colors.black.withOpacity(0.042), offset: Offset(0, -17.8), blurRadius: 50),
                      BoxShadow(color: Colors.black.withOpacity(0.05), offset: Offset(0, -33.4), blurRadius: 50),
                      BoxShadow(color: Colors.black.withOpacity(0.07), offset: Offset(0, -80.0), blurRadius: 50),
                    ], color: migWhiteColor, borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, left: 20, bottom: 15, right: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'Login',
                              style: heading1Style.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                          ),
                          Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    labelStyle: bodyStyle.copyWith(color: migBlackColor),
                                    labelText: 'Email',
                                    fillColor: migWhiteColor,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    border: circularBorder.copyWith(
                                      borderSide: BorderSide(color: migWhiteColor),
                                    ),
                                    errorBorder: circularBorder.copyWith(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    focusedBorder: circularBorder.copyWith(
                                      borderSide: BorderSide(color: migBlackColor),
                                    ),
                                    enabledBorder: circularBorder.copyWith(
                                      borderSide: BorderSide(color: migLightGreyColor),
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  style: bodyStyle.copyWith(color: migBlackColor),
                                  cursorColor: migBlackColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: migWhiteColor,
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                      color: migBlackColor.withOpacity(0.5),
                                      icon: Icon(EvaIcons.eyeOff2Outline),
                                      onPressed: () {},
                                    ),
                                    labelStyle: bodyStyle.copyWith(color: migBlackColor),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                    border: circularBorder.copyWith(
                                      borderSide: BorderSide(color: migWhiteColor),
                                    ),
                                    errorBorder: circularBorder.copyWith(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    focusedBorder: circularBorder.copyWith(
                                      borderSide: BorderSide(color: migBlackColor),
                                    ),
                                    enabledBorder: circularBorder.copyWith(
                                      borderSide: BorderSide(color: migLightGreyColor),
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  style: bodyStyle.copyWith(color: migBlackColor),
                                  cursorColor: migBlackColor,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7.5),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await viewModel.login();
                            },
                            child: viewModel.busy('login')
                                ? SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                        valueColor: AlwaysStoppedAnimation<Color>(migWhiteColor),
                                      ),
                                    ),
                                  )
                                : Text('Login'),
                            style: getButtonStyle(ButtonType.normal, 35.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                          ),
                          SizedBox.fromSize(
                            size: Size(150, 35),
                            child: TextButton(
                              onPressed: () {
                                viewModel.goToForgotPassword();
                              },
                              child: Text('Forgot Password!'),
                              style: getButtonStyle(ButtonType.flat, 10.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
