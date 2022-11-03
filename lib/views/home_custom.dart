import 'package:flutter/material.dart';
import 'package:woong_front/views/components/mysliverappbar.dart';

class HomeCustomView extends StatefulWidget {
  const HomeCustomView({super.key});

  @override
  State<HomeCustomView> createState() => _HomeCustomViewState();
}

class _HomeCustomViewState extends State<HomeCustomView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const MySliverAppBar(title: 'home'),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.amber,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text('a', style: textTheme),
            ),
            const SizedBox(width: 24),
            // _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}
