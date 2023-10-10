import 'package:mvvm_signin_out/model/addcart_model.dart';
import 'package:mvvm_signin_out/model/cartitem_model.dart';
import 'package:mvvm_signin_out/model/product_delete.dart';
import 'package:mvvm_signin_out/model/product_rating_model.dart';

import '../../model/product_detail_model.dart';
import '../../model/product_model.dart';

abstract class BaseApiServices {
  Future<dynamic> getPostSignUpApiResponse(dynamic data, String url);
  Future<dynamic> getPostLoginApiResponse(
      String url, String email, String password);

  Future<List<CategoryProductsModel>> getProductList(String url, String id);

  Future<ProductDetailModel> getProductDetail(String url, String id);

  Future<ProductRatingModel> setProductRating(
      String url, String product_id, int rating);

  Future<AddCartModel> addtocart(
      String url, String accesstoken, int quantity, int productid);

  Future<List<Datum>> listofcartitem(String url, String accesstoken);

  Future<ProductDelete> deleteproduct(
      String url, String accesstoken, int productid);
}
