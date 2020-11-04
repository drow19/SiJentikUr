class Provinsi {
  int id;
  String name;

  Provinsi({this.id, this.name});

  factory Provinsi.fromJson(Map<String, dynamic> json) {
    return Provinsi(id: json['id'], name: json['nama']);
  }


}

class Kota {
  int id;
  String idProvinsi;
  String name;

  Kota({this.id, this.name, this.idProvinsi});

  factory Kota.fromJson(Map<String, dynamic> json) {
    return Kota(
        id: json['id'], idProvinsi: json['id_provinsi'], name: json['nama']);
  }
}

class Kecamatan {
  int id;
  String idKota;
  String name;

  Kecamatan({this.id, this.idKota, this.name});

  factory Kecamatan.fromJson(Map<String, dynamic> json) {
    return Kecamatan(
        id: json['id'], idKota: json['id_kota'], name: json['nama']);
  }
}

class Kelurahan {
  int id;
  String idKecamatan;
  String name;

  Kelurahan({this.id, this.idKecamatan, this.name});

  factory Kelurahan.fromJson(Map<String, dynamic> json) {
    return Kelurahan(
        id: json['id'], idKecamatan: json['id_kecamatan'], name: json['nama']);
  }
}
