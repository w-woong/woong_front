import 'package:flutter/material.dart';
import 'package:woong_front/views/default/components/divider.dart';

class BottomInfoView extends StatelessWidget {
  const BottomInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      // color: Colors.blueGrey[50],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text('회사소개'),
              Text('이용약관'),
              Text('개인정보처리방침'),
              Text('이용안내'),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [Text('상호명 : 상호명')],
                  ),
                  Row(
                    children: [Text('대표이사 : 상호명')],
                  ),
                  Row(
                    children: [Text('주소 : 상호명')],
                  ),
                  Row(
                    children: [Text('사업자등록번호 : 상호명')],
                  ),
                  Row(
                    children: [Text('통신판매업신고 : 상호명')],
                  ),
                ],
              ),
              SizedBox(width: 10.0),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Copyright © COMPANY_NAME 2017-2023 All Rights Reserved.',
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
