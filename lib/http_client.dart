import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class HttpClient {
  // var dio = Dio();
  // static const url = 'http://151.248.117.229:8000';

  /// АВТОРИЗАЦИЯ

  Future<bool> login() async {
    // Response response = await dio.post(
    //   url + "/v1/api/dau/login",
    //   data: {"first_name": first, "last_name": second},
    // );
    // if (response.statusCode == 200) {
    //   Provider.of<SingletonProvider>(context, listen: false).token =
    //   response.data['token'];
    //   print(response.data['token']);
    //   return response.data['token'];
    // } else {
    //   throw ('getCatalogs STATUS CODE: ' + response.statusCode.toString());
    // }
    return true;
  }

  /// РАБОТА С КАТАЛОГОМ

  // Future<CategoriesModel> getCategories(context) async {
  //   var token = Provider.of<SingletonProvider>(context, listen: false).token;
  //   Response response = await dio.get(
  //       "http://151.248.117.229:8000/v1/api/dau/categories",
  //       options: Options(
  //           responseType: ResponseType.plain,
  //           headers: {'Authorization': 'Bearer $token'}));
  //
  //   if (response.statusCode == 200) {
  //     return categoriesModelFromJson(response.data);
  //   } else {
  //     throw ('getCatalogs STATUS CODE: ' + response.statusCode.toString());
  //   }
  // }

}
