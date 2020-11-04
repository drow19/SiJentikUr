import 'dart:convert';
import 'package:flutterjumantik/helper/constant.dart';
import 'package:flutterjumantik/model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<List<NewsModel>> getData(int page) async {
    String _url = '$baseUrl/berita?page=$page';

    final response = await http.get(_url);

    if (response.statusCode == 200) {
      return jsonParse(response.body);
    } else {
      throw Exception();
    }
  }

  List<NewsModel> jsonParse(final response) {
    var json = jsonDecode(response);
    var data = json['data'];

    return new List<NewsModel>.from(data.map((e) => NewsModel.fromJson(e)));
  }
}
