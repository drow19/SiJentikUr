import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterjumantik/helper/constant.dart';
import 'package:flutterjumantik/helper/shared_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ReportRepository {
  Future<String> postData(String status, String desc, var type, var photo) async {
    String _url = '$baseUrl/laporan/add';

    var id = await SharedHelper.getUserId();

    File file;
    var request = http.MultipartRequest('POST', Uri.parse(_url));

    request.fields['user_id'] = '$id';
    request.fields['status_jentik'] = status;
    request.fields['deskripsi'] = desc;
    request.headers.addAll({'content-type': 'multipart/form-data'});

    for (int i = 0; i < type.length; i++) {
      request.fields['jenis${[i]}'] = type[i];
    }

    for (int i = 0; i < photo.length; i++) {
      file = photo[i];
      var stream =
          new http.ByteStream(DelegatingStream.typed(photo[i].openRead()));
      var image = await photo[i].length();
      print(image);
      request.files.add(new http.MultipartFile('foto${[i]}', stream, image,
          contentType: MediaType('image', 'jpeg'),
          filename: file.toString().split('/').last));
    }
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print('success : ${response.statusCode}');
    if (response.statusCode == 200) {
      await Future.delayed(new Duration(seconds: 3));
      return response.body;
    } else {
      throw Exception();
    }
  }
}

