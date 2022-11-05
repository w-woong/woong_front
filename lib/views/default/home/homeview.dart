import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/domains/appconfig/appconfig.dart';
import 'package:woong_front/domains/home/home.dart';
import 'package:woong_front/domains/notice/notice.dart';
import 'package:woong_front/domains/notice/noticevm.dart';
import 'package:woong_front/domains/notice/noticerepo.dart';
import 'package:woong_front/domains/promotion/promotion.dart';
import 'package:woong_front/domains/recommend/recommend.dart';
import 'package:woong_front/views/default/components/appbar.dart';
import 'package:woong_front/views/default/components/bottomnav.dart';
import 'package:woong_front/views/default/components/divider.dart';
import 'package:woong_front/views/default/home/contents/mainpromotion.dart';
import 'package:woong_front/views/default/home/contents/recommendview.dart';
import 'package:woong_front/views/default/home/contents/shortnoticeview.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Home home;
  late ShortNoticeRepo noticeRepo;
  late ShortNoticeVM noticeVM;
  late PromotionVM promotionVM;
  late RecommendVM recommendVM;

  @override
  void initState() {
    super.initState();
    home = Home(title: 'My Home');
    noticeRepo = ShortNoticeRepo();
    noticeVM = ShortNoticeVM(repo: noticeRepo);
    noticeVM.fetchNoticeList();
    promotionVM = PromotionVM(repo: PromotionRepo());
    promotionVM.fetchPromotionList();
    recommendVM = RecommendVM(repo: RecommendRepo());
    recommendVM.fetchRecommendList();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => home,
        ),
        ChangeNotifierProvider(create: (context) => noticeVM),
        ChangeNotifierProvider(create: (context) => promotionVM),
        ChangeNotifierProvider(create: (context) => recommendVM),
      ],
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const DefaultAppBar(),
            SliverToBoxAdapter(
              child: TextButton(
                child: const Text('Refresh'),
                onPressed: () {
                  noticeVM.fetchNoticeList();
                },
              ),
            ),
            const SliverToBoxAdapter(child: DividerView()),
            const SliverToBoxAdapter(child: ShortNoticeSliderView()),
            const SliverToBoxAdapter(child: DividerView()),
            const SliverToBoxAdapter(
              child: MainPromotionView(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // return Container(
                  //   color: index.isOdd ? Colors.blue : Colors.red[200],
                  //   height: 80,
                  // );
                  return MainPromotionView();
                },
                childCount: 10,
              ),
            ),
            const SliverToBoxAdapter(child: DividerView()),
            const SliverToBoxAdapter(child: RecommendSliderView()),
            SliverToBoxAdapter(
                child: Container(color: Colors.amber, height: 100)),
          ],
        ),
        bottomNavigationBar: const BottomNavV2(),
      ),
    );
  }
}
