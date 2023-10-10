import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/model/product_model.dart';
import 'package:mvvm_signin_out/res/color.dart';
import 'package:mvvm_signin_out/utils/routes/routes_name.dart';
import 'package:mvvm_signin_out/view_model/product_model.dart';

class ProductListing extends StatefulHookConsumerWidget {
  //var id;
  final data;
  //ProductListing({super.key, required this.id});
  const ProductListing({super.key, required this.data});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductListingState();
}

class _ProductListingState extends ConsumerState<ProductListing> {
  List<CategoryProductsModel> allproducts = [];
  @override
  Widget build(BuildContext context) {
    //final productviewModel = ref.watch(prodViewModelProvider);
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: AppColor.whiteTextColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          backgroundColor: AppColor.backgroundredColor,
          title: Text(
            widget.data["title"],
            style: const TextStyle(
                fontFamily: 'Gotham',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.whiteTextColor),
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
        ),
        body: SafeArea(
          child: Center(
            child: FutureBuilder(
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If we got an error
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: const TextStyle(fontSize: 18),
                        ),
                      );

                      // if we got our data
                    } else if (snapshot.hasData) {
                      allproducts = snapshot.data!;

                      if (allproducts.isNotEmpty) {
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  var name = allproducts[index].name!;
                                  var id = allproducts[index].id!.toString();
                                  //print("$name $id");
                                  var productdata = {"name": name, "id": id};
                                  Navigator.pushNamed(
                                      context, RoutesName.productDetail,
                                      arguments: productdata);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          allproducts[index].productImages!,
                                          width: 100,
                                          height: 100,
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Text(
                                                    allproducts[index].name!,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  allproducts[index].producer!,
                                                  style: const TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Rs. ${allproducts[index].cost!}",
                                                      style: const TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    RatingBarIndicator(
                                                      rating: allproducts[index]
                                                          .rating!
                                                          .toDouble(),
                                                      itemCount: 5,
                                                      itemSize: 25,
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ))
                                      ],
                                    )),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: allproducts.length);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                },
                future: ref
                    .read(prodViewModelProvider)
                    .prodlistapi(widget.data['id'], context)

                //productviewModel.prodlistapi("2", context),
                ),
          ),
        ),
      );
    });
  }
}
