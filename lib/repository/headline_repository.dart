import 'dart:convert';
import 'package:flutterjumantik/helper/constant.dart';
import 'package:flutterjumantik/model/news_model.dart';
import 'package:http/http.dart' as http;

class HeadlineRepository {
  Future<List<NewsModel>> getData() async {
    String _url = '$baseUrl/berita/headlines';

    var response = await http.get(_url);

    if (response.statusCode == 200) {
      return jsonParse(response.body);
    } else {
      throw Exception();
    }
  }

  List<NewsModel> jsonParse(final response) {
    var json = jsonDecode(response);
    return new List<NewsModel>.from(json.map((e) => NewsModel.fromJson(e)));
  }
}
