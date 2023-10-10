import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/data/network/NetworkApiService.dart';
import 'package:mvvm_signin_out/model/product_delete.dart';
import 'package:mvvm_signin_out/model/product_rating_model.dart';
import 'package:mvvm_signin_out/model/product_detail_model.dart';

import '../data/network/BaseApiServices.dart';

import '../model/product_model.dart';
import '../res/app_url.dart';

final repositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

class ProductRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<List<CategoryProductsModel>> getProductList(String id) async {
    try {
      dynamic response =
          await _apiServices.getProductList(AppUrl.productEndPoint, id);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ProductDetailModel> getProductDetails(String id) async {
    try {
      dynamic response =
          await _apiServices.getProductDetail(AppUrl.productDetailEndPoint, id);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ProductRatingModel> setProductRating(
      String product_id, int rating) async {
    try {
      dynamic response = await _apiServices.setProductRating(
          AppUrl.productRatingEndPoint, product_id, rating);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }
}
