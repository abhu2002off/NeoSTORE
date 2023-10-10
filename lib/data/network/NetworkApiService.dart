import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
//import 'package:http/http.dart';
import 'package:mvvm_signin_out/data/app_exception.dart';
import 'package:mvvm_signin_out/data/network/BaseApiServices.dart';
import 'package:mvvm_signin_out/model/addcart_model.dart';
import 'package:mvvm_signin_out/model/cartitem_model.dart';
import 'package:mvvm_signin_out/model/product_delete.dart';
import 'package:mvvm_signin_out/model/product_rating_model.dart';
import 'package:mvvm_signin_out/model/product_detail_model.dart';
import 'package:mvvm_signin_out/model/product_model.dart';

import '../../model/auth/user_model.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getPostSignUpApiResponse(dynamic data, String url) async {
    var dio = Dio();
    dynamic usermodel;
    Response response;
    try {
      var formdata = FormData.fromMap(data);
      response = await dio
          .post(url,
              data: formdata,
              options: Options(
                validateStatus: (_) => true,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
              ))
          .timeout(const Duration(seconds: 10));
      //print(response);
      //print(jsonDecode(response.data));
      usermodel = returnResponse(response);
      // print(usermodel);
    } on SocketException {
      throw FetchDataException("No Internet Exception");
    }
    return usermodel;
  }

  @override
  Future getPostLoginApiResponse(
      String url, String email, String password) async {
    dynamic usermodel;
    Response response;
    var dio = Dio();
    Map<String, dynamic> params = {
      "email": email,
      "password": password,
    };

    try {
      // Response response = await http.post(Uri.parse(url), body: data)
      //  .timeout(const Duration(seconds: 10));
      var data = FormData.fromMap(params);
      response = await dio
          .post(url,
              data: data,
              options: Options(
                validateStatus: (_) => true,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
              ))
          .timeout(const Duration(seconds: 10));
      //print(jsonDecode(response.data));
      usermodel = returnResponse(response);

      // print(usermodel);
    } on SocketException {
      throw FetchDataException("No Internet Exception");
    }
    return usermodel;
  }

  dynamic returnResponse(response) {
    switch (response.statusCode) {
      case 200:
        UserModel usermodel = UserModel.fromJson(
            response.data) /*jsonDecode(response.data)*/ /*response*/;
        return usermodel;

      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorizedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while communicating with server' +
                'with status code' +
                response.statusCode.toString());
    }
  }

  @override
  Future<List<CategoryProductsModel>> getProductList(
      String url, String id) async {
    var dio = Dio();
    final response = await dio.get(
      url,
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
      queryParameters: Map.from({
        "product_category_id": id,
      }),
    );

    List<dynamic> data = json.decode(response.data)['data'];
    List<CategoryProductsModel> allproducts = [];
    for (var pro in data) {
      allproducts.add(CategoryProductsModel.fromJson(pro));
      // print(allproducts);
    }

    return allproducts;
  }

  @override
  Future<ProductDetailModel> getProductDetail(String url, String id) async {
    var dio = Dio();
    final response = await dio.get(
      url,
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
      queryParameters: Map.from({
        "product_id": id,
      }),
    );
    ProductDetailModel product = ProductDetailModel.fromRawJson(response.data);
    // print(product);
//    print(response);
    //  return response;
    return product;
  }

  @override
  Future<ProductRatingModel> setProductRating(
      String url, String product_id, int rating) async {
    var dio = Dio();
    Map<String, dynamic> params = {
      "product_id": product_id,
      "rating": rating,
    };

    try {
      var formdata = FormData.fromMap(params);
      final response = await dio
          .post(url,
              data: formdata,
              options: Options(
                validateStatus: (_) => true,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
              ))
          .timeout(const Duration(seconds: 10));
      ProductRatingModel product =
          ProductRatingModel.fromRawJson(response.data);
      // ProductData data = ProductData.fromRawJson(response.data);
      // print("IN Product Rating");
      //print("Product Rating :${product.data!.rating}");
      return product;
    } on SocketException {
      throw FetchDataException("No Internet Exception");
    }
  }

  @override
  Future<AddCartModel> addtocart(
      String url, String accesstoken, int quantity, int productid) async {
    var dio = Dio();

    Map<String, dynamic> params = {
      "product_id": productid,
      "quantity": quantity,
    };

    try {
      var formdata = FormData.fromMap(params);
      final response = await dio
          .post(url,
              data: formdata,
              options: Options(
                headers: {"access_token": accesstoken},
                validateStatus: (_) => true,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
              ))
          .timeout(const Duration(seconds: 10));
      //print(response);
      AddCartModel productincart = AddCartModel.fromRawJson(response.data);

      // print("Product in Carts");
      //print("Product Carted :${productincart.message}");
      return productincart;
    } on SocketException {
      throw FetchDataException("No Internet Exception");
    }
  }

  @override
  Future<List<Datum>> listofcartitem(String url, String accesstoken) async {
    var dio = Dio();
    try {
      var response = await dio.get(url,
          options: Options(
            headers: {"access_token": accesstoken},
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ));

      //print("Response   list of items in cart {$response}");
      //print("List of Items in Cart");
      List<dynamic> data = json.decode(response.data)['data'];
      print("listofcartitems : ${data}");
      int total = json.decode(response.data)['count'];
      // print("Total of all item cost is ${total}");
      List<Datum> cartitems = [];

      for (var pro in data) {
        cartitems.add(Datum.fromJson(pro));
        // print(allproducts);
      }

      print(cartitems);
      return cartitems;
    } on SocketException {
      throw FetchDataException("No Internet Exception");
    }
  }

  @override
  Future<ProductDelete> deleteproduct(
      String url, String accesstoken, int productid) async {
    var dio = Dio();

    Map<String, dynamic> params = {
      "product_id": productid,
    };
    try {
      var formdata = FormData.fromMap(params);
      final response = await dio
          .post(url,
              data: formdata,
              options: Options(
                headers: {"access_token": accesstoken},
                validateStatus: (_) => true,
                contentType: Headers.jsonContentType,
                responseType: ResponseType.json,
              ))
          .timeout(const Duration(seconds: 10));

      ProductDelete deleteproduct = ProductDelete.fromRawJson(response.data);
      print("Product Delete from Cart :${deleteproduct.message}");
      return deleteproduct;
    } on SocketException {
      throw FetchDataException("No internet Exception");
    }
  }
}
