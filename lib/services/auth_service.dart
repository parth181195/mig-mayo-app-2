import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mig_mayo/utils/constants.dart';

class AuthService {
  final _storage = new FlutterSecureStorage();
  String? _token;
  String? _refreshToken;
  Dio dio = Dio();

  readToken() async {
    _token = await _storage.read(key: Constants.jwtKey);
    return _token;
  }

  readExistingToken() {
    return _token;
  }

  readRefreshToken() async {
    _refreshToken = await _storage.read(key: Constants.jwtRefreshKey);
    return _refreshToken;
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
      return Future.wait([
        writeToken(response.data['access_token']),
        writeRefreshToken(response.data['refresh_token'])
      ]).then((value) => true);
    } catch (e) {
      print(e);
      return false;
    }
  }

  refreshToken() async {
    try {
      var response = await Dio().get(URLConstants.refreshToken,
          options: Options(headers: {'Refreshtoken': _refreshToken}));
      await writeToken(response.data['access_token']);
      await writeRefreshToken(response.data['refresh_token']);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  logOut() async {
    await _storage.deleteAll();
  }
}
