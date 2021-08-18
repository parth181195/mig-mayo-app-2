import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:mig_mayo/ui/views/forgotPassword/forgotPassword.viewmodel.dart';
import 'package:mig_ui/mig_ui.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  double textHeight = 0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
        viewModelBuilder: () => ForgotPasswordViewModel(),
        builder: (context, viewModel, child) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {},
                icon: Icon(EvaIcons.arrowBackOutline),
              ),
              iconTheme: IconThemeData(color: migBlackColor),
              backgroundColor: migWhiteColor,
              title: Text(
                'Forgot Password',
                style: bodyStyle.copyWith(color: migBlackColor),
              ),
            ),
            body: Stack(
              children: [],
            )));
  }
}

// slivers: [
// SliverPersistentHeader(
// delegate: HeaderImageDelegate(),
// pinned: true,
// ),
// SliverLayoutBuilder(
// builder: (context, constraints) {
// print(constraints);
// return Container(
// child: PageView(
// physics: NeverScrollableScrollPhysics(),
// controller: viewModel.controller,
// children: [
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.end,
// crossAxisAlignment: CrossAxisAlignment.stretch,
// // direction: Axis.vertical,
// children: [
// Text(
// 'It seems\n' + 'something got lost, lets help you\n' + 'recover it.',
// softWrap: tr
// style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
// ),
// Text(
// 'This will not reset your email password used for receiving orders*',
// softWrap: true,
// style: GoogleFonts.openSans(
// textStyle: TextStyle(color: migMediumGreyColor, fontSize: 12, fontWeight: FontWeight.w500)),
// ),
// Padding(
// padding: const EdgeInsets.only(bottom: 15.0),
// child: Text(
// 'Enter your registered Email ID',
// softWrap: true,
// style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
// ),
// ),
// TextFormField(
// obscureText: true,
// decoration: InputDecoration(
// filled: true,
// fillColor: migWhiteColor,
// labelText: 'Email',
// labelStyle: bodyStyle.copyWith(color: migBlackColor),
// contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
// border: circularBorder.copyWith(
// borderSide: BorderSide(color: migWhiteColor),
// ),
// errorBorder: circularBorder.copyWith(
// borderSide: BorderSide(color: Colors.red),
// ),
// focusedBorder: circularBorder.copyWith(
// borderSide: BorderSide(color: migBlackColor),
// ),
// enabledBorder: circularBorder.copyWith(
// borderSide: BorderSide(color: migLightGreyColor),
// ),
// ),
// keyboardType: TextInputType.emailAddress,
// style: bodyStyle.copyWith(color: migBlackColor),
// cursorColor: migBlackColor,
// ),
// Padding(
// padding: const EdgeInsets.only(bottom: 15.0),
// ),
// ElevatedButton(
// onPressed: () async {
// await viewModel.login();
// },
// child: viewModel.busy('login')
// ? SizedBox(
// width: 30,
// height: 30,
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: CircularProgressIndicator(
// strokeWidth: 1,
// valueColor: AlwaysStoppedAnimation<Color>(migWhiteColor),
// ),
// ),
// )
//     : Text('Send Otp'),
// style: getButtonStyle(ButtonType.normal, 35.0),
// ),
// ],
// ),
// ),
// Text(
// 'It seems\n' + 'something got lost, lets help you\n' + 'recover it.',
// softWrap: true,
// style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
// ),
// Text(
// 'It seems\n' + 'something got lost, lets help you\n' + 'recover it.',
// softWrap: true,
// style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
// ),
// ],
// ),
// );
// },
// )
// ],
// )
