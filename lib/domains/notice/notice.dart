class Notice {
  String title;
  List<String> messages;

  Notice({required this.title, required this.messages});
}

class ShortNotice {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String homeID;
  String imgUrl;
  String name;
  String description;

  ShortNotice(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.homeID,
      required this.imgUrl,
      required this.name,
      required this.description});

  ShortNotice.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        homeID = json['home_id'],
        createdAt =
            DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
        updatedAt =
            DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
        imgUrl = json['img_url'],
        name = json['name'],
        description = json['description'];
  // ShortNotice.fromJsonList(List<Map<String, dynamic>> json) {
  //   List<ShortNotice> list = [];
  //   for (var i = 0; i < json.length; i++) {

  //   }
  // }
}
