import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_in/models/data_model.dart';
import 'package:http/http.dart' as http;
import 'package:travel_in/models/http_server.dart';

class AuthRepository {
  Future loginUser(String _email, String _password) async {
    print('loginUser');
    try {
      final response = await Server().loginUser(_email, _password);
      return LoginAuth.fromJson(response);
    } catch (e) {
      return e;
    }
  }

  Future userLogout() async {
    print('userLogout');
    try {
      var response = await Server().userLogout();
      return Logout.fromJson(response);
    } catch (e) {
      return e;
    }
  }

  Future getData(String token) async {
    print('getData');
    String baseUrl = "http://127.0.0.1:8000/api/me";

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'applcation/json'
      });

      var body = json.decode(response.body);
      return User.fromJson(body);
    } catch (e) {
      return e;
    }
  }

  Future hasToken() async {
    print('hasToken');
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    final String token = local.getString("token_sanctum") ?? null;
    if (token != null) return token;
    return null;
  }

  Future setLocalToken(String token) async {
    print('setLocalToken');
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.setString("token_sanctum", token);
  }

  Future unsetLocalToken() async {
    print('unsetLocalToken');
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.setString("token_sanctum", null.toString());
    // local.setString("token_sanctum", toString());
  }

}
