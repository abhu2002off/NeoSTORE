import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/data/network/BaseApiServices.dart';
import 'package:mvvm_signin_out/data/network/NetworkApiService.dart';
import 'package:mvvm_signin_out/model/addcart_model.dart';
import 'package:mvvm_signin_out/model/cartitem_model.dart';
import 'package:mvvm_signin_out/model/product_delete.dart';
import 'package:mvvm_signin_out/res/app_url.dart';

final cartRepositoryProvider =
    Provider<CartRepository>((ref) => CartRepository());

class CartRepository extends ChangeNotifier {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<AddCartModel> productinCart(
      String accesstoken, int quantity, int productid) async {
    try {
      dynamic response = await _apiServices.addtocart(
          AppUrl.productincartEndPoint, accesstoken, quantity, productid);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Datum>> cartitems(String accesstoken) async {
    try {
      dynamic response = await _apiServices.listofcartitem(
          AppUrl.cartitemslistEndPoint, accesstoken);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ProductDelete> deleteProductfromCart(
      int productid, String accesstoken) async {
    try {
      dynamic response = await _apiServices.deleteproduct(
          AppUrl.deleteproductEndPoint, accesstoken, productid);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
}
