import 'package:flutter/material.dart';

class MyHomeBodySingleChildScrollView extends StatefulWidget {
  const MyHomeBodySingleChildScrollView({super.key});

  @override
  State<MyHomeBodySingleChildScrollView> createState() =>
      _MyHomeBodySingleChildScrollViewState();
}

class _MyHomeBodySingleChildScrollViewState
    extends State<MyHomeBodySingleChildScrollView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              'https://picsum.photos/250?image=9',
              // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 12),
          Image.network(
            'https://picsum.photos/250?image=9',
            // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://picsum.photos/250?image=9',
                    // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 4),
                  Image.network(
                    'https://picsum.photos/250?image=9',
                    // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 4),
                  Image.network(
                    'https://picsum.photos/250?image=9',
                    // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://picsum.photos/250?image=9',
                  // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                  fit: BoxFit.contain,
                ),
                Image.network(
                  'https://picsum.photos/250?image=9',
                  // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Image.network(
            // 'https://picsum.photos/250?image=9',
            'https://picsum.photos/250?image=9',
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
