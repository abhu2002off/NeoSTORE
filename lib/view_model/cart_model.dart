import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/model/addcart_model.dart';
import 'package:mvvm_signin_out/model/cartitem_model.dart';
import 'package:mvvm_signin_out/model/product_delete.dart';
import 'package:mvvm_signin_out/repository/cart_repository.dart';
import 'package:mvvm_signin_out/utils/routes/routes_name.dart';
import 'package:mvvm_signin_out/utils/utlis.dart';

final cartViewModelProvider = ChangeNotifierProvider<CartViewModel>((ref) {
  return CartViewModel(cartrepo: ref.read(cartRepositoryProvider));
});

class CartViewModel extends ChangeNotifier {
  final CartRepository cartrepo;

  CartViewModel({required this.cartrepo});
  List<Datum> allcartedproducts = [];
  late AddCartModel cartedProduct;
  int totalcost = 0;
  bool delreload = false;
  late ProductDelete delpro;

  Future<AddCartModel> prodaddtocart(String accesstoken, int quantity,
      int productid, BuildContext context) async {
    await cartrepo
        .productinCart(accesstoken, quantity, productid)
        .then((value) {
      var data = {"accesstoken": accesstoken};

      Navigator.of(context)
          .pushReplacementNamed(RoutesName.addtocart, arguments: data);
      Utils.flushBarErrorMessage("Product Quanity in Cart Loaded", context);
      cartedProduct = value;

      if (kDebugMode) {
        //print(value.toString());
      }
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      //print(error.toString());
    });
    notifyListeners();
    return cartedProduct;
  }

  Future<List<Datum>> listofcarteditems(
      String accesstoken, BuildContext context) async {
    var value = await cartrepo.cartitems(accesstoken);

    allcartedproducts = value;
    delreload = false;

    int len = allcartedproducts.length;
    if (len == 0) {
      totalcost = 0;
    } else {
      for (int i = 0; i < len; i++) {
        totalcost += allcartedproducts[i].product!.subTotal!;
      }
    }

    // .then((value) {
    //   Utils.flushBarErrorMessage(" List of Cart Items Loaded", context);
    //   if (value == null) {
    //     value = [];
    //   }
    // print("Cart after deleted");
    // print(value);
    // allcartedproducts = value;
    // delreload = false;
    // int len = allcartedproducts.length;
    // for (int i = 0; i < len; i++) {
    //   totalcost += allcartedproducts[i].product!.subTotal!;
    // }

    //   if (kDebugMode) {
    //     print(value.toString());
    //   }
    // }).onError((error, stackTrace) {
    //   Utils.flushBarErrorMessage(error.toString(), context);
    // });
    //notifyListeners();
    return allcartedproducts;
  }

  Future<ProductDelete> prodDeletefromCart(
      String accesstoken, int productid, BuildContext context) async {
    await cartrepo.deleteProductfromCart(productid, accesstoken).then((value) {
      delpro = value;
      delreload = true;
      listofcarteditems(accesstoken, context);
      Utils.flushBarErrorMessage(" Item Deleted Successfully", context);

      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
    });
    notifyListeners();
    return delpro;
  }
}
