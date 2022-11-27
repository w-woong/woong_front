class Tag {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String ownerType;
  String ownerID;
  String name;

  Tag(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.ownerType,
      required this.ownerID,
      required this.name});

  Tag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt =
            DateTime.parse(json['created_at'] ?? "2006-01-02T01:01:01+09:00"),
        updatedAt =
            DateTime.parse(json['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
        ownerType = json['owner_type'],
        ownerID = json['owner_id'],
        name = json['name'];
}
