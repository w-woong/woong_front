import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/domains/home/home.dart';
import 'package:woong_front/domains/notice/noticevm.dart';
import 'package:woong_front/domains/promotion/promotion.dart';
import 'package:woong_front/domains/recommend/recommend.dart';
import 'package:woong_front/views/default/components/appbar.dart';
import 'package:woong_front/views/default/components/divider.dart';
import 'package:woong_front/views/default/components/dynamic.dart';
import 'package:woong_front/views/default/home/contents/bottominfo.dart';
import 'package:woong_front/views/default/home/contents/mainpromotion.dart';
import 'package:woong_front/views/default/home/contents/recommendview.dart';
import 'package:woong_front/views/default/home/contents/shortnoticeview.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return _HomeBody(key: UniqueKey());
  }
}

class _HomeBody extends StatefulWidget {
  const _HomeBody({super.key});

  @override
  State<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<_HomeBody> {
  late ScrollController _scrollController;
  double position = 0.0;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _scrollController.animateTo(context.read<Home>().position,
    //       duration: Duration(milliseconds: 500), curve: Curves.ease);
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  var csvKey = PageStorageKey(UniqueKey());
  @override
  Widget build(BuildContext context) {
    print('_HomeBodyState build');
    List<Promotion> promotionList =
        context.select((PromotionVM vm) => vm.promotionList);

    _scrollController =
        ScrollController(initialScrollOffset: context.read<Home>().position);
    _scrollController.addListener(() {
      context.read<Home>().position = _scrollController.offset;
    });

    return CustomScrollView(
      key: csvKey,
      controller: _scrollController,
      slivers: [
        const DefaultAppBar(),
        SliverToBoxAdapter(
          child: TextButton(
            child: const Text('Refresh'),
            onPressed: () {
              context.read<ShortNoticeVM>().fetchNoticeList();
              context.read<PromotionVM>().fetchPromotionList();
              context.read<RecommendVM>().fetchRecommendList();
            },
          ),
        ),
        const SliverToBoxAdapter(child: DividerView()),
        const SliverToBoxAdapter(child: ShortNoticeSliderView()),
        const SliverToBoxAdapter(child: DividerView()),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return MainPromotionView(
                promotion: promotionList[index],
              );
            },
            childCount: promotionList.length,
          ),
        ),
        const SliverToBoxAdapter(child: DividerView()),
        const SliverToBoxAdapter(child: RecommendSliderView()),
        const SliverToBoxAdapter(child: DividerView()),
        const SliverToBoxAdapter(child: DynamicProductsView()),
        const SliverToBoxAdapter(child: DividerView()),
        const SliverToBoxAdapter(
          child: BottomInfoView(),
        ),
      ],
    );
  }
}
