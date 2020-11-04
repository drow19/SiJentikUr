class UserModel {
  int id;
  String nama;
  String email;

  UserModel({this.id, this.nama, this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], nama: json['nama'], email: json['email']);
  }
}
