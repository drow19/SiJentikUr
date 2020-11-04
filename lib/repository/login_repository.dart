import 'package:flutterjumantik/helper/constant.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  Future<String> getData(String email, String password) async {
    String _url = '$baseUrl/mandiri/login';

    print("print url: $_url");

    final response =
        await http.post(_url, body: {'email': email, 'password': password});

    if(response.statusCode == 200){
      return response.body;
    }else{
      throw Exception();
    }
  }
}
