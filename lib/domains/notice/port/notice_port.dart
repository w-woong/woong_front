import 'package:woong_front/domains/notice/model/notice.dart';

abstract class ShortNoticeService {
  Future<List<ShortNotice>> getNoticeList();
}
