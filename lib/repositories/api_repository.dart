import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_in/models/data_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  var dio = Dio();
  static const baseUrl = 'https://www.mockachino.com/192910f0-ae70-4e/';

  Future loginUser(String _email, String _password) async {
    final data = {"login": _password, "password": _password};
    final url = baseUrl + "loginUser";

    Response response = await dio.post(
      url,
      data: data,
    );
    if (response.statusCode == 200) {
      return LoginAuth.fromJson(response.data);
    } else {
      throw ('loginUser STATUS CODE: ' + response.statusCode.toString());
    }
  }

  Future userLogout(String token) async {
    final url = baseUrl + "userLogout";
    Response response = await dio.post(url);
    if (response.statusCode == 200) {
      return Logout.fromJson(response.data);
    } else {
      throw ('userLogout STATUS CODE: ' + response.statusCode.toString());
    }
  }

  Future getData(String token) async {
    print('getData');
    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });

      var body = json.decode(response.body);
      return User.fromJson(body);
    } catch (e) {
      return e;
    }
  }

  Future hasToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    final String token = local.getString("token_sanctum") ?? null;
    if (token != null) return token;
    return null;
  }

  Future setLocalToken(String token) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.setString("token_sanctum", token);
  }

  Future unsetLocalToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.setString("token_sanctum", null.toString());
  }
}
