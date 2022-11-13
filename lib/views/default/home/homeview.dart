import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/domains/home/home.dart';
import 'package:woong_front/domains/home/homevm.dart';
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
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<void> _onRefresh() async {
    context.read<HomeVM>().loading();
    refreshKey.currentState?.show(atTop: false);
    await context.read<ShortNoticeVM>().fetchNoticeList();
    await context.read<PromotionVM>().fetchPromotionList();
    await context.read<RecommendVM>().fetchRecommendList();
    context.read<HomeVM>().finishedLoading();
    // await Future.delayed(Duration(seconds: 2));

    return Future<void>.value();
  }

  @override
  Widget build(BuildContext context) {
    // return _HomeBody(key: UniqueKey());
    return RefreshIndicator(
      key: refreshKey,
      edgeOffset: 120,
      displacement: 20,
      onRefresh: _onRefresh,
      child: _HomeBody(key: UniqueKey()),
    );
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

    HomeVM homeVM = context.select((HomeVM value) => value);
    Home home = homeVM.home;
    List<Promotion> promotionList =
        context.select((PromotionVM vm) => vm.promotionList);

    _scrollController = ScrollController(initialScrollOffset: home.position);
    _scrollController.addListener(() {
      home.position = _scrollController.offset;
    });

    return CustomScrollView(
      key: csvKey,
      controller: _scrollController,
      slivers: [
        const DefaultAppBar(),
        SliverToBoxAdapter(
          child: AnimatedContainer(
            // color: Colors.amber,
            curve: Curves.easeIn,
            duration:
                context.select((HomeVM value) => value.loadingAnimDuration),
            height: context.select((HomeVM value) => value.loadingAreaHeight),
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
