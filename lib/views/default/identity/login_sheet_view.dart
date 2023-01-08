import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:woong_front/domains/identity/loginvm.dart';
import 'package:woong_front/views/default/product/contents/bottombar.dart';

class LoginSheetView extends StatefulWidget {
  const LoginSheetView({super.key});

  @override
  State<LoginSheetView> createState() => _LoginSheetViewState();
}

class _LoginSheetViewState extends State<LoginSheetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Login',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [],
      ),
      body: _LoginSheetBody(),
      bottomNavigationBar: const BottomBar(isSheet: true),
    );
  }
}

class _LoginSheetBody extends StatefulWidget {
  const _LoginSheetBody({super.key});

  @override
  State<_LoginSheetBody> createState() => _LoginSheetBodyState();
}

class _LoginSheetBodyState extends State<_LoginSheetBody> {
  @override
  Widget build(BuildContext context) {
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
