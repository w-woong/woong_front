import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/domains/home/model/home.dart';
import 'package:woong_front/domains/home/viewmodel/home_vm.dart';
import 'package:woong_front/domains/notice/viewmodel/noticevm.dart';
import 'package:woong_front/domains/product/model/group.dart';
import 'package:woong_front/domains/promotion/model/promotion.dart';
import 'package:woong_front/domains/promotion/promotion.dart';
import 'package:woong_front/domains/recommend/recommend.dart';
import 'package:woong_front/views/default/commonviews/group_product_horizontal_grid_view.dart';
import 'package:woong_front/views/default/commonviews/group_product_view.dart';
import 'package:woong_front/views/default/components/appbar.dart';
import 'package:woong_front/views/default/components/bottomnav.dart';
import 'package:woong_front/views/default/components/divider.dart';
import 'package:woong_front/views/default/components/dynamic.dart';
import 'package:woong_front/views/default/home/contents/bottominfo.dart';
import 'package:woong_front/views/default/home/contents/mainpromotion.dart';
import 'package:woong_front/views/default/home/contents/recommendview.dart';
import 'package:woong_front/views/default/home/contents/shortnoticeview.dart';

class HomeView extends StatefulWidget {
  final List<ScaffoldWithNavBarTabItem> bottomTabs;
  const HomeView({super.key, required this.bottomTabs});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    // return _HomeBody(key: UniqueKey());

    return Scaffold(
      body: const _HomeBody(),
      bottomNavigationBar: BottomNavV2(
        tabs: widget.bottomTabs,
      ),
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
    // Home home = homeVM.home;
    List<Promotion> promotionList =
        context.select((HomeVM value) => value.home.mainPromotionList ?? []);
    List<Group> mainProducts = homeVM.home.mainProducts!;

    _scrollController = ScrollController(initialScrollOffset: homeVM.position);
    _scrollController.addListener(() {
      homeVM.position = _scrollController.offset;
    });

    return CustomScrollView(
      key: csvKey,
      controller: _scrollController,
      slivers: [
        DefaultAppBar(
            title: homeVM.home.name, showCart: true, showAccount: true),
        // const SliverToBoxAdapter(child: DividerView()),
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if ((mainProducts[index].products ?? []).isEmpty) {
                return null;
              }
              return GroupProductView(
                group: mainProducts[index],
              );
            },
            childCount: mainProducts.length,
          ),
        ),
        const SliverToBoxAdapter(child: DividerView()),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if ((mainProducts[index].products ?? []).isEmpty) {
                return null;
              }
              return GroupProductHorizontalGridView(
                group: mainProducts[index],
              );
            },
            childCount: mainProducts.length,
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
