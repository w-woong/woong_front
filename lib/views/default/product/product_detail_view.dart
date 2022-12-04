import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:woong_front/commons/strings.dart';
import 'package:woong_front/domains/notice/notice.dart';
import 'package:woong_front/domains/product/mandatory.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:woong_front/domains/product/product_detail_repo.dart';
import 'package:woong_front/domains/product/product_detail_vm.dart';
import 'package:woong_front/views/default/commonviews/noticeview.dart';
import 'package:woong_front/views/default/commonviews/short_notice.dart';
import 'package:woong_front/views/default/components/appbar.dart';
import 'package:woong_front/views/default/components/carousel_slider.dart';
import 'package:woong_front/views/default/components/divider.dart';
import 'package:woong_front/views/default/components/textview.dart';
import 'package:woong_front/views/default/product/contents/bottombar.dart';
import 'package:woong_front/views/default/product/contents/madatory.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductDetailView extends StatefulWidget {
  final Product product;
  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  void initState() {
    print('_ProductDetailViewState initState');
    super.initState();
    // productDetailVM.fetch(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    print('_ProductDetailViewState ${widget.product.id}');
    context.read<ProductDetailVM>().fetch(widget.product.id);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.product.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: _ProductBody(
          product: context.select((ProductDetailVM vm) => vm.product)),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class _ProductBody extends StatefulWidget {
  final Product product;
  // final imgList = [
  //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  // ];
  const _ProductBody({super.key, required this.product});

  @override
  State<_ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<_ProductBody> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      controller: ModalScrollController.of(context),
      slivers: [
        const SliverToBoxAdapter(child: DividerView()),
        SliverToBoxAdapter(
          child: ImageCarouselSlider(
            imgList: widget.product.topImgUrlList,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
        ),
        // const SliverToBoxAdapter(child: DividerView()),
        SliverToBoxAdapter(
          child: Container(
            // color: Colors.amber,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TitleLargeText(
                        text: widget.product.name,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TitleLargeText(
                        text: '₩ ${widget.product.price}',
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
            padding: const EdgeInsets.all(10),
            child: ShortNoticeView(
              shortNotice: ShortNotice(
                  id: '',
                  homeID: '',
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  imgUrl: '',
                  name: 'Delivery',
                  description: 'It is free.'),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: DividerView()),
        SliverToBoxAdapter(
          child: MandatoryView(
            mandatory: Mandatory('a', 'KC Cert', 'about kc cert',
                certMarkUrl: 'assets/images/app/kcmark.gif',
                certificateNumber: 'asdf-asdf-asdf-asdf-asdf'),
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
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(20),
            child: NoticeView(
              notice: Notice(title: 'Refund', messages: [
                StringUtils.randomeString(50),
                StringUtils.randomeString(50),
                StringUtils.randomeString(50),
              ]),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: DividerView()),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(20),
            child: NoticeView(
              notice: Notice(title: 'Exchange', messages: [
                StringUtils.randomeString(50),
                StringUtils.randomeString(50),
                StringUtils.randomeString(50),
              ]),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: DividerView()),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(20),
            child: NoticeView(
              notice: Notice(title: 'AS', messages: [
                StringUtils.randomeString(50),
                StringUtils.randomeString(50),
                StringUtils.randomeString(50),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
