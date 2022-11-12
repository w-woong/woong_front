import 'package:flutter/material.dart';
import 'package:woong_front/views/default/components/appbar.dart';
import 'package:woong_front/views/default/components/bottomnav.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
              style: Theme.of(context).textTheme.displayLarge,
            ),
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
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/catalog');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.yellow,
              ),
              child: const Text('ENTER'),
            )
          ],
        ),
      ),
    );
  }
}
