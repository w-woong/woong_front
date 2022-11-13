import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

import 'package:woong_front/domains/identity/login.dart';
// import 'package:woong_front/views/default/components/appbar.dart';
// import 'package:woong_front/views/default/components/bottomnav.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _LoginBody(key: UniqueKey());
  }
}

class _LoginBody extends StatefulWidget {
  const _LoginBody({super.key});

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  @override
  Widget build(BuildContext context) {
    print('_loginBodyState build');
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(80.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await context.read<LoginVM>().authorize();
                        context.go('/home');
                      } catch (e) {}
                    },
                    child: Text('Login with Google'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/home');
                    },
                    child: Text('Home'),
                  ),
                  Text(context.select((LoginVM value) => value.login.tid)),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    // return Center(
    //   child: Container(
    //     padding: const EdgeInsets.all(80.0),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(
    //           'Welcome',
    //           style: Theme.of(context).textTheme.headline2,
    //         ),
    //         const SizedBox(height: 24),
    //         ElevatedButton(
    //           onPressed: () {
    //             try {
    //               context.read<LoginVM>().authorize();
    //               context.go('/home');
    //             } catch (e) {}
    //           },
    //           child: Text('Login with Google'),
    //         ),
    //         const SizedBox(height: 24),
    //         ElevatedButton(
    //           onPressed: () {
    //             context.go('/home');
    //           },
    //           child: Text('Home'),
    //         ),
    //         Text(context.select((LoginVM value) => value.login.tid)),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class _LoginBodyExample extends StatefulWidget {
  const _LoginBodyExample({super.key});

  @override
  State<_LoginBodyExample> createState() => _LoginBodyExampleState();
}

class _LoginBodyExampleState extends State<_LoginBodyExample> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 24),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/catalog');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.yellow,
              ),
              child: const Text('ENTER'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LoginVM>().authorize();
              },
              child: Text('google login'),
            ),
            Text(context.select((LoginVM value) => value.login.tid)),
          ],
        ),
      ),
    );
  }
}
