import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/model/product_delete.dart';
import 'package:mvvm_signin_out/model/product_rating_model.dart';
import 'package:mvvm_signin_out/model/product_model.dart';

import '../model/product_detail_model.dart';
import '../repository/prod_repository.dart';

import '../utils/routes/routes_name.dart';
import '../utils/utlis.dart';

final prodViewModelProvider = ChangeNotifierProvider<ProductViewModel>((ref) {
  return ProductViewModel(ProdRepo: ref.read(repositoryProvider));
});

class ProductViewModel extends ChangeNotifier {
  final ProductRepository ProdRepo;
  ProductViewModel({required this.ProdRepo});

  int index = 0;
  late ProductDetailModel product;
  List<CategoryProductsModel> result = [];

  photoindexchange(val) {
    index = val;
    notifyListeners();
  }

  Future<List<CategoryProductsModel>> prodlistapi(
      String id, BuildContext context) async {
    // List<CategoryProductsModel> result = [];

    await ProdRepo.getProductList(id).then((value) {
      Utils.flushBarErrorMessage("Product List Loaded", context);
      result = value;
      if (kDebugMode) {
        // print(value.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
    notifyListeners();
    return result;
  }

  Future<ProductDetailModel> prodDetailapi(
      String id, BuildContext context) async {
    //late ProductDetailModel product;
    await ProdRepo.getProductDetails(id).then((value) {
      Utils.flushBarErrorMessage("Product Details Loaded", context);
      product = value;

      if (kDebugMode) {
        //print(value.toString());
      }
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error.toString());
    });
    // notifyListeners();
    return product;
  }

  Future<ProductRatingModel> prodRatingapi(
      String id, String product_id, int rating, BuildContext context) async {
    late ProductRatingModel productrating;
    await ProdRepo.setProductRating(product_id, rating).then((value) {
      prodDetailapi(product_id, context);
      prodlistapi(id, context);
      Navigator.of(context).pushReplacementNamed(RoutesName.layout);
      Utils.flushBarErrorMessage("Product Rating Loaded", context);
      productrating = value;
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      //print(error.toString());
    });
    notifyListeners();
    return productrating;
  }
}
