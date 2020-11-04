import 'package:flutterjumantik/helper/constant.dart';
import 'package:http/http.dart' as http;

class PostDataProfile {
  Future<String> postData(String id, String email, String provinsi, String kota,
      String kec, String kel, String alamat, String rt, String rw) async {

    String _url = '$baseUrl/mandiri/update_biodata';

    final response = await http.post(_url, body: {
      'user_id': id,
      'email': email,
      'provinsi': provinsi,
      'kota': kota,
      'kecamatan': kec,
      'kelurahan': kel,
      'alamat': alamat,
      'rt': rt,
      'rw': rw
    });

    print('response $_url');
    print('response ${response.body}');

    if(response.statusCode == 200){
      await Future.delayed(const Duration(seconds: 3));
      return response.body;
    }else{
      throw Exception();
    }
  }
}