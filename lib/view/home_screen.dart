import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/res/color.dart';
import 'package:mvvm_signin_out/utils/routes/routes_name.dart';

import '../view_model/icon_home.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool menuOpen = false;
  double tranx = 0, trany = 0, scale = 1;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, child) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(tranx, trany, 0)..scale(scale),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(menuOpen ? 30 : 0),
            color: const Color.fromARGB(255, 255, 255, 255)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(menuOpen ? 10 : 0),
                  color: AppColor.backgroundredColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*Consumer(builder: (context, ref, child) {
                  return */
                  !ref.watch(MenuIconVmHomeProvider).ismenuOpen
                      ? IconButton(
                          onPressed: () {
                            scale = 0.6;
                            tranx = size.width - 100;
                            trany = (size.height - size.height * scale) / 2;
                            ref.watch(MenuIconVmHomeProvider).onMenuIconPress();
                            /*setState(() {
                            menuOpen = true;
                          });*/
                          },
                          color: Colors.white,
                          icon: const Icon(Icons.menu))
                      : IconButton(
                          onPressed: () {
                            scale = 1.0;
                            tranx = 0;
                            trany = 0;
                            ref.watch(MenuIconVmHomeProvider).onMenuIconPress();
                            /*setState(() {
                            menuOpen = false;
                          });*/
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                          color: AppColor.whiteTextColor),
                  //}),
                  const Text(
                    "NeoSTORE",
                    style: TextStyle(
                        color: AppColor.whiteTextColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                    color: AppColor.whiteTextColor,
                  )
                ],
              ),
            ),
            ExpandableCarousel(
              options: CarouselOptions(
                viewportFraction: 1,
                enlargeCenterPage: true,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 4),
              ),
              items: ["chairs.jpg", "cupboard.jpg", "sofas.jpg", "table.jpg"]
                  .map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width - 10,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 0.0),
                        decoration: const BoxDecoration(color: Colors.black),
                        child: Image.asset(
                          'assets/images/carousel_image/$i',
                          fit: BoxFit.cover,
                        ));
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 20, right: 15),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      var id = "1";
                      var title = "Tables";
                      Map data = {"id": id, "title": title};
                      Navigator.pushNamed(context, RoutesName.productlisting,
                          arguments: data);
                    },
                    child: Container(
                      height: 170,
                      width: 170,
                      color: AppColor.backgroundredColor,
                      child: const Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(18),
                              child: Text(
                                "Tables",
                                style: TextStyle(
                                    fontFamily: 'Gotham',
                                    fontSize: 22,
                                    color: AppColor.whiteTextColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Icon(
                                Icons.table_bar,
                                size: 100,
                                color: AppColor.whiteTextColor,
                              ),
                            )
                          ],
                        )
                      ]),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      var id = "2";
                      var title = "Sofas";
                      Map data = {"id": id, "title": title};
                      print(MediaQuery.of(context).size.width);
                      Navigator.pushNamed(context, RoutesName.productlisting,
                          arguments: data);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                          height: 170,
                          width: 170,
                          color: AppColor.backgroundredColor,
                          child: const Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                    child: Icon(
                                      Icons.chair,
                                      size: 100,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, bottom: 2, top: 20),
                                    child: Text(
                                      "Sofas",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: "Gotham",
                                          color: AppColor.whiteTextColor),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      var id = '3';
                      var title = 'Chairs';
                      Map data = {"id": id, "title": title};
                      Navigator.pushNamed(context, RoutesName.productlisting,
                          arguments: data);
                    },
                    child: Container(
                      height: 170,
                      width: 170,
                      color: AppColor.backgroundredColor,
                      child: const Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, top: 10.0),
                                  child: Text(
                                    'Chairs',
                                    style: TextStyle(
                                        color: AppColor.whiteTextColor,
                                        fontFamily: 'Gotham',
                                        fontSize: 22),
                                  ),
                                )
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 25.0),
                                child: Icon(Icons.chair_alt_rounded,
                                    color: AppColor.whiteTextColor, size: 100),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: InkWell(
                      onTap: () {
                        var id = '4';
                        var title = "CupBoards";
                        Map data = {"id": id, "title": title};
                        Navigator.pushNamed(context, RoutesName.productlisting,
                            arguments: data);
                      },
                      child: Container(
                        height: 170,
                        width: 170,
                        color: AppColor.backgroundredColor,
                        child: const Column(children: [
                          Row(children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, top: 15),
                              child: Icon(
                                Icons.curtains_closed_outlined,
                                size: 100,
                                color: AppColor.whiteTextColor,
                              ),
                            ),
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 15, right: 15),
                                child: Text(
                                  "Cupboards",
                                  style: TextStyle(
                                      fontFamily: 'Gotham',
                                      fontSize: 22,
                                      color: AppColor.whiteTextColor),
                                ),
                              ),
                            ],
                          )
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
