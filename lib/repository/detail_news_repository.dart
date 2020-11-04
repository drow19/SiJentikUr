import 'dart:convert';
import 'package:flutterjumantik/helper/constant.dart';
import 'package:flutterjumantik/model/news_model.dart';
import 'package:http/http.dart' as http;

class DetailNewsRepository {
  Future<NewsModel> getData(String id) async {
    String _url = '$baseUrl/berita/detail/$id';

    final response = await http.get(_url);

    if (response.statusCode == 200) {
      return NewsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }
}
