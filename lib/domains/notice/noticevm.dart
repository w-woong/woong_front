import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:woong_front/domains/notice/notice.dart';
import 'package:woong_front/domains/notice/noticerepo.dart';

class ShortNoticeVM extends ChangeNotifier {
  ShortNoticeRepo repo;
  List<ShortNotice> noticeList;

  ShortNoticeVM({required this.repo}) : noticeList = [];

  void fetchNoticeList() async {
    noticeList = await repo.getNoticeList();
    notifyListeners();
  }
}
