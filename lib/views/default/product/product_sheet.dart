import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:woong_front/domains/notice/notice.dart';
import 'package:woong_front/views/default/commonviews/short_notice.dart';
import 'package:woong_front/views/default/components/appbar.dart';
import 'package:woong_front/views/default/components/carousel_slider.dart';
import 'package:woong_front/views/default/components/divider.dart';
import 'package:woong_front/views/default/components/textview.dart';

class ProductSheetView extends StatefulWidget {
  const ProductSheetView({super.key});

  @override
  State<ProductSheetView> createState() => _ProductSheetViewState();
}

class _ProductSheetViewState extends State<ProductSheetView> {
  final imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: ScrollController(),
        physics: ScrollPhysics(parent: PageScrollPhysics()),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            DefaultAppBar(title: 'Product'),
          ];
        },
        body: _ProductBody(),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        bottom: true,
        child: Container(
          height: 50,
          child: Container(
            color: Colors.amber,
            child: Text('Buy'),
          ),
        ),
      ),
    );

    // return NestedScrollView(
    //   controller: ScrollController(),
    //   physics: ScrollPhysics(parent: PageScrollPhysics()),
    //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //     return <Widget>[
    //       SliverList(
    //         delegate: SliverChildListDelegate(
    //           [
    //             Container(height: 300, color: Colors.blue),
    //           ],
    //         ),
    //       ),
    //     ];
    //   },
    //   body: _ProductBody(),
    // );

    // return Scaffold(
    //   body: _ProductBody(),
    //   bottomNavigationBar: SafeArea(
    //     top: false,
    //     bottom: true,
    //     child: Container(
    //       height: 50,
    //       child: Container(
    //         color: Colors.amber,
    //         child: Text('Buy'),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class _ProductBodyV2 extends StatefulWidget {
  final imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  ];
  _ProductBodyV2({super.key});

  @override
  State<_ProductBodyV2> createState() => _ProductBodyV2State();
}

class _ProductBodyV2State extends State<_ProductBodyV2> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        // These are the slivers that show up in the "outer" scroll view.
        return <Widget>[
          SliverOverlapAbsorber(
            // This widget takes the overlapping behavior of the SliverAppBar,
            // and redirects it to the SliverOverlapInjector below. If it is
            // missing, then it is possible for the nested "inner" scroll view
            // below to end up under the SliverAppBar even when the inner
            // scroll view thinks it has not been scrolled.
            // This is not necessary if the "headerSliverBuilder" only builds
            // widgets that do not overlap the next sliver.
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              title: const Text('Books'), // This is the title in the app bar.
              pinned: true,
              expandedHeight: 150.0,
              // The "forceElevated" property causes the SliverAppBar to show
              // a shadow. The "innerBoxIsScrolled" parameter is true when the
              // inner scroll view is scrolled beyond its "zero" point, i.e.
              // when it appears to be scrolled below the SliverAppBar.
              // Without this, there are cases where the shadow would appear
              // or not appear inappropriately, because the SliverAppBar is
              // not actually aware of the precise position of the inner
              // scroll views.
              forceElevated: innerBoxIsScrolled,
            ),
          ),
        ];
      },
      body: SafeArea(
        top: false,
        bottom: false,
        child: Builder(
          // This Builder is needed to provide a BuildContext that is
          // "inside" the NestedScrollView, so that
          // sliverOverlapAbsorberHandleFor() can find the
          // NestedScrollView.
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: DividerView()),
                SliverToBoxAdapter(
                  child: ImageCarouselSlider(
                    imgList: widget.imgList,
                    height: MediaQuery.of(context).size.height * 0.6,
                  ),
                ),
                const SliverToBoxAdapter(child: DividerView()),
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.amber,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TitleLargeText(
                                text: 'Product Name',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TitleLargeText(
                                text: '2,000',
                                align: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 600,
                        )
                      ],
                    ),
                  ),
                ),
                // SliverToBoxAdapter(
                //   child: Container(
                //     height: MediaQuery.of(context).size.height * 0.6,
                //     color: Colors.amber,
                //     child: Image.network(
                //       'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ProductBody extends StatefulWidget {
  final imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  ];
  _ProductBody({super.key});

  @override
  State<_ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<_ProductBody> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: ModalScrollController.of(context),
      slivers: [
        // const DefaultAppBar(title: 'Product'),
        // SliverToBoxAdapter(
        //   child: Container(
        //     // height: 70,
        //     height: null,
        //     color: Colors.red,
        //     child: Container(
        //       // height: 100,
        //       color: Colors.amber,
        //       child: Text(
        //         'a',
        //         style: Theme.of(context).textTheme.headline1,
        //       ),
        //     ),
        //   ),
        // ),
        const SliverToBoxAdapter(child: DividerView()),
        SliverToBoxAdapter(
          child: ImageCarouselSlider(
            imgList: widget.imgList,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
        ),
        // const SliverToBoxAdapter(child: DividerView()),
        SliverToBoxAdapter(
          child: Container(
            // color: Colors.amber,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TitleLargeText(
                        text: 'Product Name',
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TitleLargeText(
                        text: '₩ 2,000',
                        align: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: DividerView()),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(10),
            child: ShortNoticeView(
              shortNotice: ShortNotice(
                  imgUrl: '', name: 'Delivery', description: 'It is free.'),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: DividerView()),
        SliverToBoxAdapter(
          child: Container(
            // height: 300,
            color: Colors.blue,
            child: Image.asset(
              'assets/images/app/sample_product_info.png',
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: DividerView()),
      ],
    );
  }
}
