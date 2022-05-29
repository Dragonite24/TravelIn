import 'package:travel_in/models/data_model.dart';

class Server {
  Future<Map<String, dynamic>> loginUser(String login, String password) async {
    print('loginUser');
    Map<String, dynamic> onValue(value) {
      if (login == 'admin' && password == 'admin') {
        final Map<String, dynamic> data = {
          'data': '',
          'message': 'token: "asd"'
        };
        return data;
      } else {
        return null;
      }
    }

    return await Future.delayed(Duration(seconds: 2)).then(onValue);
  }

  Future<Map<String, dynamic>> userLogout() async {
    print('userLogout');
    return await Future.delayed(Duration(seconds: 2))
        .then((value) => {"message": 'true'});
  }

  Future<void> getData() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
