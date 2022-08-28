import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mig_mayo/utils/constants.dart';

class AuthService {
  final _storage = new FlutterSecureStorage();
  String? _token;
  String? _refreshToken;
  Dio dio = Dio();

  readToken() async {
    try {
      if(_token != null){
        return _token;
      }
      _token = await _storage.read(key: Constants.jwtKey);
      return _token;
    } catch (e) {}
  }

  readExistingToken() {
    return _token;
  }

  readRefreshToken() async {
    try {
      if(_refreshToken != null){
        return _refreshToken;
      }
      _refreshToken = await _storage.read(key: Constants.jwtRefreshKey);
      return _refreshToken;
    } catch (e) {}
  }

  Future writeToken(String token) {
    _token = token;
    return _storage.write(key: Constants.jwtKey, value: token);
  }

  Future writeRefreshToken(String token) {
    _refreshToken = token;
    return _storage.write(key: Constants.jwtRefreshKey, value: token);
  }

  login(String email, String password) async {
    Map<String, String> payload = {'email': email, 'password': password};
    try {
      var response = await Dio().post(URLConstants.login, data: payload);
      print(response);
     await  Future.wait([
        writeToken(response.data['access_token']),
        writeRefreshToken(response.data['refresh_token'])
      ]).then((value) {
        print(value);
        return true;
      });
      return Future.delayed(Duration(milliseconds: 800)).then((value) => true);
    } catch (e) {
      print(e);
      return false;
    }
  }

  refreshToken() async {
    try {
      var response = await Dio().get(URLConstants.refreshToken,
          options: Options(headers: {'Refreshtoken': _refreshToken}));
      await Future.wait([
        writeToken(response.data['access_token']),
        writeRefreshToken(response.data['refresh_token'])
      ]);
      return response.data['access_token'];
    } catch (e) {
      print(e);
      return Future.value(false);
    }
  }

  logOut() async {
    await _storage.deleteAll();
  }
}
