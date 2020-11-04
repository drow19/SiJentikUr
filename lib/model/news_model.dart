class NewsModel {
  int id;
  String cover;
  String title;
  String desc;
  String date;
  String content;

  NewsModel(
      {this.id, this.cover, this.title, this.date, this.desc, this.content});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
        id: json['id'],
        title: json['judul'],
        desc: json['deskripsi'],
        date: json['tanggal'],
        cover: json['cover'],
        content: json['konten'] ?? "");
  }
}
