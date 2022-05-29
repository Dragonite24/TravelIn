class Api {
  final String _token = 'iamaccestoken';

  Future<String> getToken() async {
    return _token;
  }
}
