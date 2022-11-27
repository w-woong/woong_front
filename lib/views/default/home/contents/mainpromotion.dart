import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woong_front/domains/identity/loginrepo.dart';
import 'package:woong_front/domains/identity/loginvm.dart';
import 'package:woong_front/domains/promotion/promotion.dart';

class MainPromotionView extends StatelessWidget {
  Promotion promotion;

  MainPromotionView({super.key, required this.promotion});

  // final String imgUrl =
  //     'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80';

  @override
  Widget build(BuildContext context) {
    print('MainPromotionView build');
    return SizedBox(
      // height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    promotion.imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0.0,
                  left: 0,
                  right: 0,
                  child: Container(
                    // margin: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   promotion.getJoinedTags(),
                        //   style: Theme.of(context).textTheme.bodyLarge,
                        // ),
                        // Text(
                        //   promotion.name,
                        //   style: Theme.of(context).textTheme.displayMedium,
                        // ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              // colors: [
                              //   Color.fromARGB(100, 0, 0, 0),
                              //   Color.fromARGB(0, 0, 0, 0)
                              // ],
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(150, 0, 0, 0),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            // borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                promotion.getJoinedTags(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                promotion.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: 10.0, top: 10.0, right: 10.0, bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    promotion.description,
                    maxLines: 2,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  child: Text('buy'),
                  onPressed: () {
                    if (!context.read<LoginVM>().isAuthorized()) {
                      print('sdf');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    foregroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
