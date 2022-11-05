import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

// for usePathUrlStrategy();
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:woong_front/examples/mocks/database.dart';

// models
import 'package:woong_front/examples/models/appconfig.dart';
import 'package:woong_front/examples/mocks/database.dart';

// views
import 'package:woong_front/examples/views/home.dart';
import 'package:woong_front/examples/views/home_custom.dart';
import 'package:woong_front/examples/views/home_customscrollview.dart';
import 'package:woong_front/examples/views/home_singlechildscrollview.dart';

class ExampleHomeView extends StatefulWidget {
  const ExampleHomeView({super.key});

  @override
  State<ExampleHomeView> createState() => _ExampleHomeViewState();
}

class _ExampleHomeViewState extends State<ExampleHomeView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AppConfigModel(title: '')),
        ChangeNotifierProvider(
          create: (context) => AppConfigProv(
            repo: AppConfigRepo(),
            model: AppConfigModel(title: ''),
          ),
        ),
        StreamProvider<int>.value(
          value: Person(name: 'wonk', stayedSecond: 0).getStayedSecond,
          initialData: 0,
        ),
        StreamProvider<List<Product>>.value(
          value: Product(name: 'c').products,
          initialData: const [],
        ),
        // StreamProvider(
        //   create: (context) {
        //     return Person(name: 'won', stayedSecond: 0).getStayedSecond;
        //   },
        //   initialData: 0,
        //   catchError: (context, error) => error.toString(),
        // ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: Colors.white,

          // Define the default font family.
          fontFamily: 'Georgia',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.normal),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
        routerConfig: _router,
        title: 'Woong',
      ),
    );
  }

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return HomeCustomScrollView();
        },
      ),
      GoRoute(
        path: '/homev2',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeCustomView();
        },
      ),
      GoRoute(
        path: '/homev3',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeSingleChildScrollView();
        },
      ),
      GoRoute(
        path: '/nested',
        builder: (BuildContext context, GoRouterState state) {
          return NestedListView('asdf');
        },
      ),
    ],
  );
}

//
//
//
//
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future<http.Response> get() {
    return http.get(Uri.parse('https://localhost:5558/auth'));
  }

  Future<void> getAsync() async {
    http.Response response =
        await http.get(Uri.parse('https://localhost:5558/auth'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return print(response);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  // Future<void> launchInBrowser(String url) async {
  //   if (!await launchUrl(
  //     Uri.parse(url),
  //     mode: LaunchMode.externalApplication,
  //   )) {
  //     throw 'Could not launch';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // launchInBrowser('https://localhost:5558/auth?id=1234');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
