import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:woong_front/commons/exceptions/auth_exceptions.dart';
// import 'package:provider/provider.dart';
import 'package:woong_front/domains/notice/model/notice.dart';
import 'package:woong_front/domains/notice/port/notice_port.dart';

class ShortNoticeVM extends ChangeNotifier {
  ShortNoticeService svc;
  List<ShortNotice> noticeList;

  ShortNoticeVM({required this.svc}) : noticeList = [];

  Future<void> fetchNoticeList() async {
    try {
      noticeList = await svc.getNoticeList();
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException(e.message);
      }
      throw e.message;
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}
