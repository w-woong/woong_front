import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/domains/identity/loginvm.dart';
import 'package:woong_front/views/default/components/appbar.dart';
import 'package:woong_front/views/default/components/bottomnav.dart';
import 'package:woong_front/views/default/components/divider.dart';

class UserAccountView extends StatefulWidget {
  final List<ScaffoldWithNavBarTabItem> bottomTabs;
  const UserAccountView({super.key, required this.bottomTabs});

  @override
  State<UserAccountView> createState() => _UserAccountViewState();
}

class _UserAccountViewState extends State<UserAccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _UserAccountBody(),
      bottomNavigationBar: BottomNavV2(tabs: widget.bottomTabs),
    );
  }
}

class _UserAccountBody extends StatefulWidget {
  const _UserAccountBody({super.key});

  @override
  State<_UserAccountBody> createState() => _UserAccountBodyState();
}

class _UserAccountBodyState extends State<_UserAccountBody> {
  @override
  Widget build(BuildContext context) {
    // var userIdentity = context.select((LoginVM vm) => vm.userIdentity);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return CustomScrollView(
          slivers: [
            DefaultAppBar(title: 'Account', showCart: true, showAccount: false),
            const SliverToBoxAdapter(child: DividerView()),
            SliverToBoxAdapter(
              child: Container(
                child: Text('a'),
              ),
            ),
          ],
        );
      },
    );
  }
}
