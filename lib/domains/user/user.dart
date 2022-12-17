class User {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String loginID;
  String loginType;
  String loginSource;

  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.loginID,
    required this.loginType,
    required this.loginSource,
  });

  User.empty()
      : id = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        loginID = '',
        loginType = '',
        loginSource = '';

  User.fromJson(Map<String, dynamic> m)
      : id = m['id'],
        createdAt =
            DateTime.parse(m['created_at'] ?? "2006-01-02T01:01:01+09:00"),
        updatedAt =
            DateTime.parse(m['updated_at'] ?? "2006-01-02T01:01:01+09:00"),
        loginID = m['login_id'],
        loginType = m['login_type'],
        loginSource = m['login_source'];

  bool isEmpty() {
    if (id == '' && loginID == '') {
      return true;
    }
    return false;
  }
}
