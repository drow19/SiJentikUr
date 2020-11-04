class MateriModel {
  int id;
  String title;
  String desc;
  String date;

  MateriModel({this.id, this.desc, this.title, this.date});

  factory MateriModel.fromJson(Map<String, dynamic> json) {
    return MateriModel(
        id: json['id'],
        title: json['judul'],
        desc: json['isi'],
        date: json['tanggal']);
  }
}
