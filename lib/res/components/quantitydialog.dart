import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/repository/cart_repository.dart';
import 'package:mvvm_signin_out/res/color.dart';
import 'package:mvvm_signin_out/utils/routes/routes_name.dart';
import 'package:mvvm_signin_out/view_model/cart_model.dart';
import 'package:mvvm_signin_out/view_model/user_view_model.dart';

class QuantityDialog extends StatefulHookConsumerWidget {
  final data;
  const QuantityDialog({super.key, this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuantityDialogState();
}

class _QuantityDialogState extends ConsumerState<QuantityDialog> {
  TextEditingController? _quantityController;
  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.sizeOf(context).width / 1.1,
          height: MediaQuery.sizeOf(context).height / 1.6,
          decoration: BoxDecoration(
              color: AppColor.whiteTextColor,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.data.name,
                style: const TextStyle(
                    fontFamily: "Gotham",
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              Container(
                width: MediaQuery.sizeOf(context).width / 1.4,
                height: MediaQuery.sizeOf(context).height / 4.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            NetworkImage(widget.data.productImages![0].image),
                        fit: BoxFit.fill)),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              Center(
                child: Column(children: [
                  Text(
                    "Enter Qty",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Gotham",
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.02,
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Material(
                      child: TextFormField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.02,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      fixedSize: MaterialStateProperty.all(const Size(180, 55)),
                      backgroundColor: MaterialStateProperty.all(
                          AppColor.backgroundredColor),
                    ),
                    onPressed: () {
                      final user = ref.watch(loginprovider).userdata;

                      Map<String, dynamic> userlogin = {};
                      userlogin = jsonDecode(user)["data"];
                      // print(_quantityController!.text);
                      //print((widget.data.id).runtimeType);
                      int quantity = int.parse(_quantityController!.text);
                      int productid = widget.data.id;
                      print("Quanitity :{$quantity} ,Product Id {$productid}");
                      ref.read(cartViewModelProvider).prodaddtocart(
                          userlogin["access_token"].toString(),
                          quantity,
                          productid,
                          context);
                    },
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(
                          color: AppColor.whiteTextColor, fontSize: 20),
                    ),
                  ),
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
