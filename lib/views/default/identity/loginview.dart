import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:woong_front/domains/identity/loginvm.dart';
import 'package:woong_front/views/default/components/bottomnav.dart';

class LoginView extends StatefulWidget {
  final List<ScaffoldWithNavBarTabItem> bottomTabs;
  const LoginView({super.key, required this.bottomTabs});

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
    // return _LoginBody(key: UniqueKey());
    return Scaffold(
      body: _LoginBody(),
      bottomNavigationBar: BottomNavV2(tabs: widget.bottomTabs),
    );
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
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text('Login with Google'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/home');
                    },
                    child: Text('Home'),
                  ),
                  Text('tid'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await context.read<LoginVM>().findAccount();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text('Account info'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await context.read<LoginVM>().logout();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
