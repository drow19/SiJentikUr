import 'package:flutterjumantik/helper/constant.dart';
import 'package:http/http.dart' as http;

class RegisterRepository {
  Future<String> postData(String username, String email, String password,
      String confirmation) async {
    String _url = '$baseUrl/mandiri/register';

    final response = await http.post(_url, body: {
      'nama': username,
      'email': email,
      'password': password,
      'konfirmasi_password': confirmation
    });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception();
    }
  }
}
