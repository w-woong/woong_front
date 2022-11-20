class Notice {
  String title;
  List<String> messages;

  Notice({required this.title, required this.messages});
}

class ShortNotice {
  String imgUrl;
  String name;
  String description;

  ShortNotice(
      {required this.imgUrl, required this.name, required this.description});
}
