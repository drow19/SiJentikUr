import 'dart:convert';
import 'package:flutterjumantik/helper/constant.dart';
import 'package:flutterjumantik/model/region_model.dart';
import 'package:http/http.dart' as http;

class ProvinsiRepository {
  Future<List<Provinsi>> getData() async {
    String _url = '$provinceUrl';

    final response = await http.get(_url);

    print(response.body);

    if (response.statusCode == 200) {
      Future.delayed(const Duration(seconds: 2));
      return jsonParse(response.body);
    } else {
      throw Exception();
    }
  }

  List<Provinsi> jsonParse(final response) {
    var json = jsonDecode(response);
    var data = json['provinsi'];

    return new List<Provinsi>.from(
        data.map((value) => Provinsi.fromJson(value)));
  }
}

class KotaRepository {
  Future<List<Kota>> getData(String id) async {
    String _url = '$cityUrl=$id';

    final response = await http.get(_url);

    if (response.statusCode == 200) {
      Future.delayed(const Duration(seconds: 2));
      return jsonParse(response.body);
    } else {
      throw Exception();
    }
  }

  List<Kota> jsonParse(final response) {
    var json = jsonDecode(response);
    var data = json['kota_kabupaten'];

    return new List<Kota>.from(data.map((value) => Kota.fromJson(value)));
  }
}

class KecamatanRepository {
  Future<List<Kecamatan>> getData(String id) async {
    String _url = '$subDistrictUrl=$id';

    final response = await http.get(_url);

    if (response.statusCode == 200) {
      return jsonParse(response.body);
    } else {
      throw Exception();
    }
  }

  List<Kecamatan> jsonParse(final response) {
    var json = jsonDecode(response);
    var data = json['kecamatan'];

    return new List<Kecamatan>.from(
        data.map((value) => Kecamatan.fromJson(value)));
  }
}

class KelurahanRepository {
  Future<List<Kelurahan>> getData(String id) async {
    String _url = '$subDistrictRegionUrl=$id';

    final response = await http.get(_url);

    if (response.statusCode == 200) {
      return jsonParse(response.body);
    } else {
      throw Exception();
    }
  }

  List<Kelurahan> jsonParse(final response) {
    var json = jsonDecode(response);
    var data = json['kelurahan'];

    return new List<Kelurahan>.from(
        data.map((value) => Kelurahan.fromJson(value)));
  }
}
