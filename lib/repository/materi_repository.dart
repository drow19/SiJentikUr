import 'dart:convert';
import 'package:flutterjumantik/helper/constant.dart';
import 'package:flutterjumantik/model/materi_model.dart';
import 'package:http/http.dart' as http;

class MateriRepository {
  Future<List<MateriModel>> getData(String page) async {
    String _url = '$baseUrl/materi?page=$page';

    final response = await http.get(_url);

    if (response.statusCode == 200) {
      return jsonParse(response.body);
    } else {
      throw Exception();
    }
  }

  List<MateriModel> jsonParse(final response) {
    var json = jsonDecode(response);
    var data = json['data'];

    return new List<MateriModel>.from(data.map((e) => MateriModel.fromJson(e)));
  }
}
