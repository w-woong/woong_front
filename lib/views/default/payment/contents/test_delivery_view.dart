import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:woong_front/constants/constants.dart';
import 'package:woong_front/constants/routes.dart';

class TestDeliveryView extends StatefulWidget {
  const TestDeliveryView({super.key});

  @override
  State<TestDeliveryView> createState() => _TestDeliveryViewState();
}

class _TestDeliveryViewState extends State<TestDeliveryView> {
  var ctrl = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: ((progress) {
          print('progress');
        }),
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {
          print(error.description);
        },
        onNavigationRequest: (NavigationRequest request) {
          // if (request.url.startsWith('https://www.youtube.com/')) {
          //   return NavigationDecision.prevent;
          // }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..addJavaScriptChannel(
      'messageHandler',
      onMessageReceived: (JavaScriptMessage message) {
        print(message.message);
      },
    )
    // ..loadRequest(
    //     Uri.parse(
    //         AppConstant.partnerBaseUrl + AppConstant.partnerFindAddressPath),
    //     headers: {'Authorization': 'Bearer ${AppConstant.bearerToken}'})
    ..loadRequest(
        Uri.parse('${AppConstant.partnerBaseUrl}/v1/partner/address'));
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: WebViewWidget(controller: ctrl),
      width: 300,
      height: 500,
    );
  }
}
