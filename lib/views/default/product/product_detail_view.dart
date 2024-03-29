import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:woong_front/commons/strings.dart';
import 'package:woong_front/domains/notice/model/notice.dart';
import 'package:woong_front/domains/product/mandatory.dart';
import 'package:woong_front/domains/product/model/product.dart';
import 'package:woong_front/domains/product/product.dart';
import 'package:woong_front/domains/product/adapter/product_detail_http.dart';
import 'package:woong_front/domains/product/viewmodel/product_detail_vm.dart';
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
  final bool isSheet;
  const ProductDetailView({
    super.key,
    required this.product,
    required this.isSheet,
  });

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  void initState() {
    print('_ProductDetailViewState initState');
    super.initState();
    context.read<ProductDetailVM>().fetch(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    print('_ProductDetailViewState ${widget.product.id}');
    // context.read<ProductDetailVM>().fetch(widget.product.id);
    return Scaffold(
      appBar: widget.isSheet
          ? AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                  ),
                ),
              ],
              title: Text(
                widget.product.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          : null,
      body: _ProductBody(
        product: context.select((ProductDetailVM vm) => vm.product),
        isSheet: widget.isSheet,
      ),
      bottomNavigationBar: BottomBar(
        isSheet: widget.isSheet,
        product: widget.product,
      ),
    );
  }
}

class _ProductBody extends StatefulWidget {
  final Product product;
  final bool isSheet;
  const _ProductBody({super.key, required this.product, required this.isSheet});

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
        // AppBar
        widget.isSheet
            ? SliverToBoxAdapter(child: Container())
            : DefaultAppBar(
                title: widget.product.name, showCart: true, showAccount: false),
        const SliverToBoxAdapter(child: DividerView()),
        // Main product images
        SliverToBoxAdapter(
          child: ImageCarouselSlider(
            imgList: widget.product.topImgUrlList,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
        ),
        // Main product info
        SliverToBoxAdapter(
          child: Container(
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
                        text: '₩ ${widget.product.priceWithCommas}',
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
