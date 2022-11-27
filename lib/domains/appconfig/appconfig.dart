class AppConfig {
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  AppConfig(
      {required this.name,
      required this.id,
      required this.createdAt,
      required this.updatedAt});

  AppConfig.empty()
      : id = '',
        name = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  AppConfig.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        createdAt =
            DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
        updatedAt =
            DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00");

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt
    };
  }

  bool isEmpty() {
    if (id == '') {
      return true;
    }
    return false;
  }

  // String get title => _title;

  // set title(String title) {
  //   _title = title;
  // }

}
