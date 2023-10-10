import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/model/cartitem_model.dart';
import 'package:mvvm_signin_out/res/color.dart';
import 'package:mvvm_signin_out/res/components/button.dart';
import 'package:mvvm_signin_out/res/components/dropdown.dart';

import 'package:mvvm_signin_out/view_model/cart_model.dart';

class AddCart extends StatefulHookConsumerWidget {
  var data;

  AddCart({super.key, required this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCartState();
}

class _AddCartState extends ConsumerState<AddCart> {
  List<Datum> allcartedproducts = [];
  int len = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: AppColor.whiteTextColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            "My Cart ",
            style: TextStyle(
                color: AppColor.whiteTextColor,
                fontFamily: "Gotham",
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: AppColor.whiteTextColor,
              ),
            )
          ],
          centerTitle: true,
          backgroundColor: AppColor.backgroundredColor,
        ),
        body: Center(
            child: FutureBuilder(
                future: ref.watch(cartViewModelProvider).delreload
                    ? ref
                        .watch(cartViewModelProvider)
                        .listofcarteditems(widget.data["accesstoken"], context)
                    : ref
                        .watch(cartViewModelProvider)
                        .listofcarteditems(widget.data["accesstoken"], context),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            '${snapshot.error} occurred',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      );

                      // if we got our data
                    } else if (snapshot.hasData) {
                      allcartedproducts = snapshot.data!;
                      print("List of Products at UI: {$allcartedproducts}");
                      len = allcartedproducts.length;
                      if (allcartedproducts.isNotEmpty) {
                        return Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.65,
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, top: 15.0, bottom: 5),
                                      child: Slidable(
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  ref
                                                      .read(
                                                          cartViewModelProvider)
                                                      .prodDeletefromCart(
                                                          widget.data[
                                                              "accesstoken"],
                                                          allcartedproducts[
                                                                  index]
                                                              .productId!,
                                                          context);
                                                },
                                                style: ButtonStyle(
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          const CircleBorder()),
                                                  padding:
                                                      MaterialStateProperty.all(
                                                          const EdgeInsets.all(
                                                              15)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors
                                                              .blue), // <-- Button color
                                                  overlayColor:
                                                      MaterialStateProperty
                                                          .resolveWith<Color?>(
                                                              (states) {
                                                    if (states.contains(
                                                        MaterialState
                                                            .pressed)) {
                                                      return AppColor
                                                          .backgroundredColor;
                                                    } else {
                                                      return null;
                                                    }
                                                    // <-- Splash color
                                                  }),
                                                ),
                                                child: const Icon(
                                                  Icons.delete,
                                                  size: 26,
                                                ))
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              color: const Color.fromARGB(
                                                  255, 219, 217, 217),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Image.network(
                                                  allcartedproducts[index]
                                                      .product!
                                                      .productImages!,
                                                  width: 100,
                                                  height: 100,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      allcartedproducts[index]
                                                          .product!
                                                          .name!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                    Text(
                                                      "(${allcartedproducts[index].product!.productCategory!})",
                                                      style: const TextStyle(
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 25,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Dropdown(
                                                            quantity:
                                                                allcartedproducts[
                                                                        index]
                                                                    .quantity
                                                                    .toString()),
                                                        const SizedBox(
                                                          width: 125,
                                                        ),
                                                        Text(
                                                          "Rs.${allcartedproducts[index].product!.subTotal!}",
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemCount: allcartedproducts.length),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.20,
                              child: Column(children: [
                                const Divider(
                                  height: 10,
                                  thickness: 2,
                                  endIndent: 0,
                                  color: Color.fromARGB(255, 188, 186, 186),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(27.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "TOTAL",
                                        style: TextStyle(
                                            fontFamily: 'Gotham', fontSize: 20),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                      ),
                                      Text(
                                        "₹ ${ref.read(cartViewModelProvider).totalcost}",
                                        style: const TextStyle(
                                            fontFamily: 'Gotham', fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 10,
                                  thickness: 2,
                                  endIndent: 0,
                                  color: Color.fromARGB(255, 188, 186, 186),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        backgroundColor:
                                            AppColor.backgroundredColor,
                                        minimumSize:
                                            const Size.fromHeight(50), // NEW
                                      ),
                                      onPressed: () {},
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          'Order Now',
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColor.whiteTextColor,
                                            fontFamily: 'Gotham',
                                            fontSize: 24,
                                          ),
                                        ),
                                      )),
                                )
                              ]),
                            ),
                          ],
                        );
                      }
                    }
                  }
                  return const CircularProgressIndicator();
                })));
  }
}
