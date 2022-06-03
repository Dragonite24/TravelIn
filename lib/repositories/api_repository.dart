import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_in/models/attractions_model.dart';
import 'package:travel_in/models/data_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/adapter.dart';

class AuthRepository {
  var dio = Dio(BaseOptions(
        baseUrl: "https://www.mockachino.com/192910f0-ae70-4e/",
        connectTimeout: 8000,
        receiveTimeout: 8000,
        headers: {HttpHeaders.userAgentHeader: 'dio', 'common-header': 'xx'},
      ));

  Future loginUser(String _email, String _password) async {
    final data = {"login": _password, "password": _password};

    Response response = await dio.post(
      "loginUser",
      data: data,
    );
    if (response.statusCode == 200) {
      return LoginAuth.fromJson(response.data);
    } else {
      throw ('loginUser STATUS CODE: ' + response.statusCode.toString());
    }
  }

  Future userLogout(String token) async {
    Response response = await dio.post("userLogout");
    if (response.statusCode == 200) {
      return Logout.fromJson(response.data);
    } else {
      throw ('userLogout STATUS CODE: ' + response.statusCode.toString());
    }
  }

  Future<AttractionModel> getAttractions() async {
    try {
      Response response = await dio.get("getAttractions");

      if (response.statusCode == 200) {
        final AttractionModel attractionModel =
            AttractionModel.fromJson(response.data);
        print('done');
        return attractionModel;
      } else {
        throw ('getAttractions STATUS CODE: ' + response.statusCode.toString());
      }
    } catch (e) {
      throw ('getAttractions error: $e');
    }
  }

  Future getData(String token) async {
    try {
      var response = await http.get(Uri.parse(''), headers: {
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
