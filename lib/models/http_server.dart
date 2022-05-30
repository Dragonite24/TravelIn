import 'package:dio/dio.dart';
import 'package:travel_in/models/data_model.dart';

class Server {



  Future<Map<String, dynamic>> userLogout() async {
    print('userLogout');
    return await Future.delayed(Duration(seconds: 2))
        .then((value) => {"message": 'true'});
  }

  Future<void> getData() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
