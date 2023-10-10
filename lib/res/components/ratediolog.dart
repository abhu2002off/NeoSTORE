// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_signin_out/res/color.dart';

import '../../model/product_detail_model.dart';
import '../../view_model/product_model.dart';

class RateDialog extends StatefulWidget {
  ProductDetailModel data;
  RateDialog({super.key, required this.data});

  @override
  State<RateDialog> createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  double rate = 0;
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width / 1.1,
        height: MediaQuery.sizeOf(context).height / 1.6,
        decoration: BoxDecoration(
            color: AppColor.whiteTextColor,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close_outlined),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Text(
              widget.data.name!,
              style: const TextStyle(
                  fontFamily: "Gotham",
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width / 1.4,
              height: MediaQuery.sizeOf(context).height / 3.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.data.productImages![0].image!),
                      fit: BoxFit.fill)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.027,
            ),
            Center(
              child: Column(children: [
                Text(
                  "Rate",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Gotham",
                      color: Colors.grey.shade700),
                ),
                const SizedBox(
                  height: 5,
                ),
                // SizedBox(
                //   width: MediaQuery.sizeOf(context).width / 1.4,
                //   height: 50,
                //   child: Center(
                //     child: RatingBarIndicator(
                //       rating: widget.data.rating,
                //       itemCount: 5,
                //       itemSize: 50,
                //       physics: const BouncingScrollPhysics(),
                //       itemBuilder: (context, _) => const Icon(
                //         Icons.star,
                //         color: Colors.amber,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.2,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Center(
                    child: RatingBar.builder(
                      itemSize: 50,
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        rate = rating;
                        flag = true;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Consumer(
                  builder: (context, ref, child) => TextButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      fixedSize: MaterialStateProperty.all(const Size(180, 55)),
                      backgroundColor: MaterialStateProperty.all(
                          AppColor.backgroundredColor),
                    ),
                    onPressed: () async {
                      dynamic ress;
                      if (flag) {
                        ress = await ref
                            .read(prodViewModelProvider)
                            .prodRatingapi(
                                widget.data.productCategoryId.toString(),
                                widget.data.productCategoryId.toString(),
                                widget.data.rating!,
                                context);
                        // Navigator.pop(context, ress);
                      } else {
                        Navigator.pop(context, ress);
                      }
                    },
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(
                          color: AppColor.whiteTextColor, fontSize: 20),
                    ),
                  ),
                ),
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
