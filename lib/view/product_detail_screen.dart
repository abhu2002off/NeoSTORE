import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/model/product_detail_model.dart';
import 'package:mvvm_signin_out/res/color.dart';
import 'package:intl/intl.dart';

import '../res/components/quantitydialog.dart';
import '../res/components/ratediolog.dart';
import '../view_model/product_model.dart';

class ProductDetail extends StatefulHookConsumerWidget {
  final data;
  const ProductDetail({super.key, required this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductDetailState();
}

class _ProductDetailState extends ConsumerState<ProductDetail> {
  Map types = {
    "1": "Tables",
    "2": "Chaires",
    "3": "Sofas",
    "5": "Dinning Sets"
  };
  var formatter = NumberFormat('#,##,000');
  ProductDetailModel? product;

  @override
  Widget build(BuildContext context) {
    //var data = ref.watch(prodViewModelProvider).product;
    //print(widget.data);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColor.whiteTextColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.data['name'] ?? "",
          style: const TextStyle(
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
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontFamily: 'Gotham', fontSize: 18),
                ),
              );

              // if we got our data
            } else if (snapshot.hasData) {
              product = snapshot.data!;
              var data = ref.watch(prodViewModelProvider).product;
              return Container(
                color: const Color.fromARGB(255, 205, 203, 203),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 127,
                        color: AppColor.whiteTextColor,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(product!.name!,
                                  style: const TextStyle(
                                      fontFamily: 'Gotham',
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                  "Category-${types[product!.productCategoryId.toString()]}",
                                  style: const TextStyle(
                                      fontFamily: 'Gotham',
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300)),
                              const SizedBox(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(product!.producer!,
                                      style: const TextStyle(
                                          fontFamily: 'Gotham',
                                          color: Colors.grey,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500)),
                                  RatingBarIndicator(
                                      rating: product!.rating!.toDouble(),
                                      itemCount: 5,
                                      itemSize: 23,
                                      itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.whiteTextColor,
                              ),
                              height: MediaQuery.sizeOf(context).height / 2.4,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Rs. ${formatter.format(product!.cost)}",
                                        style: const TextStyle(
                                            fontFamily: 'Gotham',
                                            fontSize: 30,
                                            color:
                                                Color.fromARGB(255, 41, 27, 27),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Icon(
                                        Icons.share,
                                        size: 30,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                  Consumer(
                                    builder: (context, ref, child) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                1.5,
                                        height:
                                            MediaQuery.sizeOf(context).width /
                                                2.5,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(product!
                                                    .productImages![ref
                                                        .watch(
                                                            prodViewModelProvider)
                                                        .index]
                                                    .image!),
                                                fit: BoxFit.fill)),
                                      ),
                                    ),
                                  ),
                                  Consumer(
                                    builder: (context, ref, child) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: product!.productImages!
                                          .map<Widget>((data) {
                                        return InkWell(
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width /
                                                5,
                                            height: MediaQuery.sizeOf(context)
                                                    .width /
                                                5,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        data.image!),
                                                    fit: BoxFit.fill)),
                                          ),
                                          onTap: () {
                                            // print("hello");
                                            ref
                                                .read(prodViewModelProvider)
                                                .photoindexchange(product!
                                                    .productImages!
                                                    .indexOf(data));
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.whiteTextColor,
                              ),
                              height: MediaQuery.sizeOf(context).height / 4.8,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SingleChildScrollView(
                                  child: SizedBox(
                                    width: MediaQuery.sizeOf(context).width,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "DESCRIPTION",
                                            style: TextStyle(
                                                fontFamily: 'Gotham',
                                                fontSize: 21,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            product!.description!,
                                            style: TextStyle(
                                                fontFamily: 'Gotham',
                                                fontSize: 15,
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height / 12,
                        color: AppColor.whiteTextColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(180, 40)),
                                backgroundColor: MaterialStateProperty.all(
                                    AppColor.backgroundredColor),
                              ),
                              onPressed: () {
                                print(product!.productImages![0].image);
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      QuantityDialog(data: product),
                                );
                              },
                              child: const Text(
                                "BUY NOW",
                                style: TextStyle(
                                    fontFamily: 'Gotham',
                                    color: AppColor.whiteTextColor,
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              style: ButtonStyle(
                                alignment: Alignment.center,
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(180, 40)),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.grey.shade300),
                              ),
                              onPressed: () async {
                                var data = await showDialog(
                                  context: context,
                                  builder: (context) =>
                                      RateDialog(data: product!),
                                );
                                if (data != null) {
                                  var snackBar = SnackBar(
                                    content: Text(data["user_msg"]),
                                  );
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Text(
                                "RATE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Gotham',
                                    color: Colors.grey.shade600,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
        future: ref
            .read(prodViewModelProvider)
            .prodDetailapi(widget.data['id'], context),
      ),
    );
  }
}
