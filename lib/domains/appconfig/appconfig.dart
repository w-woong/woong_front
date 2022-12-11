class AppConfig {
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  int shoppingNumColumns;

  AppConfig(
      {required this.name,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.shoppingNumColumns});

  AppConfig.empty()
      : id = '',
        name = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        shoppingNumColumns = 2;

  AppConfig.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        createdAt =
            DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
        updatedAt =
            DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
        shoppingNumColumns = json['shopping_num_columns'] ?? 2;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'shopping_num_columns': shoppingNumColumns,
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
