import 'package:flutter/material.dart';
import 'package:woong_front/domains/product/mandatory.dart';
import 'package:woong_front/views/default/components/textview.dart';

class MandatoryView extends StatelessWidget {
  final Mandatory mandatory;
  const MandatoryView({super.key, required this.mandatory});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 40.0),
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            padding: EdgeInsets.all(5),
            child: Image.asset(
              mandatory.certMarkUrl,
              fit: BoxFit.contain,
            ),
          ),
          // ImageIcon(
          //   // NetworkImage(widget.item.imgUrl),
          //   AssetImage(mandatory.certMarkUrl),
          //   size: 40,
          //   // color: Colors.black,
          // ),
          const SizedBox(width: 10),
          Expanded(
            // width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: TitleText(mandatory.name)),
                    TextButton(
                      onPressed: () {
                        //
                      },
                      child: Text('more'),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(5),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 2),
                BodyText(mandatory.description),
                const SizedBox(height: 2),
                Row(
                  children: [
                    BodyText('Certificate Number:'),
                    Expanded(child: BodyText(mandatory.certificateNumber)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
