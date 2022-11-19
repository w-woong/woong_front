import 'package:flutter/material.dart';
import 'package:woong_front/views/default/components/appbar.dart';

class ProductSheetView extends StatefulWidget {
  const ProductSheetView({super.key});

  @override
  State<ProductSheetView> createState() => _ProductSheetViewState();
}

class _ProductSheetViewState extends State<ProductSheetView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        DefaultAppBar(title: 'Product'),
        SliverToBoxAdapter(
          child: Expanded(child: Text('a')),
        ),
      ],
    );
    // return return CustomScrollView(
    //   key: csvKey,
    //   controller: _scrollController,
    //   slivers: [
    //     DefaultAppBar(
    //       title: homeVM.home.title,
    //     ),
    //     SliverToBoxAdapter(
    //       child: AnimatedContainer(
    //         // color: Colors.amber,
    //         curve: Curves.easeIn,
    //         duration:
    //             context.select((HomeVM value) => value.loadingAnimDuration),
    //         height: context.select((HomeVM value) => value.loadingAreaHeight),
    //       ),
    //     ),
    //     const SliverToBoxAdapter(child: DividerView()),
    //     const SliverToBoxAdapter(child: ShortNoticeSliderView()),
    //     const SliverToBoxAdapter(child: DividerView()),
    //     SliverList(
    //       delegate: SliverChildBuilderDelegate(
    //         (context, index) {
    //           return MainPromotionView(
    //             promotion: promotionList[index],
    //           );
    //         },
    //         childCount: promotionList.length,
    //       ),
    //     ),
    //     const SliverToBoxAdapter(child: DividerView()),
    //     const SliverToBoxAdapter(child: RecommendSliderView()),
    //     const SliverToBoxAdapter(child: DividerView()),
    //     const SliverToBoxAdapter(child: DynamicProductsView()),
    //     const SliverToBoxAdapter(child: DividerView()),
    //     const SliverToBoxAdapter(
    //       child: BottomInfoView(),
    //     ),
    //   ],
    // );;
  }
}
