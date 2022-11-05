import 'package:flutter/material.dart';

class MainPromotionView extends StatelessWidget {
  const MainPromotionView({super.key});

  final String imgUrl =
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'tags',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'title',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('description'),
                Expanded(child: SizedBox()),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: TextButton(
                    child: Text('hey'),
                    onPressed: () {
                      print('pressed');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
