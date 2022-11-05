import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/examples/models/appconfig.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var appConfigTitle = context.select<AppConfigModel, String>(
      (value) => value.title,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(appConfigTitle),
      ),
      body: listViewBody,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet),
            label: 'haha',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.safety_check),
            label: 'hehe',
          ),
        ],
      ),
    );
  }

  final Widget listViewBody = ListView(
    children: [
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Image.network(
            // 'https://picsum.photos/250?image=9',
            'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
            fit: BoxFit.contain,
          ),
        ),
      ),
      SizedBox(
        height: 110,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 32,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(4),
              child: Image.network(
                'https://picsum.photos/250?image=9',
              ),
            );
          },
        ),
      ),

      Expanded(
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Image.network(
            // 'https://picsum.photos/250?image=9',
            'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
            fit: BoxFit.contain,
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Image.network(
            // 'https://picsum.photos/250?image=9',
            'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
            fit: BoxFit.contain,
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Image.network(
            // 'https://picsum.photos/250?image=9',
            'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
            fit: BoxFit.contain,
          ),
        ),
      ),
      // Expanded(
      //   child: ListView.builder(
      //     scrollDirection: Axis.horizontal,
      //     itemCount: 10,
      //     itemBuilder: (context, index) {
      //       return Card(
      //         child: Center(child: Text('hello')),
      //       );
      //     },
      //   ),
      // ),
    ],
  );
}

class NestedListView extends StatelessWidget {
  final String title;
  final List<int> _header = List.generate(9, (index) => index + 1);
  final List<int> _body = List.generate(9, (index) => index + 1);

  NestedListView(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
          itemCount: _header.length,
          itemBuilder: (_, index) {
            int dan = _header[index];
            return Column(
              children: [
                Chip(label: Text('$dan 단')),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _body.length,
                    itemBuilder: (_, index) {
                      int num = _body[index];
                      return Card(
                          child: ListTile(
                              title: Text('$dan x $num = ${dan * num}')));
                    })
              ],
            );
          }),
    );
  }
}
