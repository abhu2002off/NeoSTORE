import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/data/network/BaseApiServices.dart';
import 'package:mvvm_signin_out/data/network/NetworkApiService.dart';

import '../res/app_url.dart';

final repositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostSignUpApiResponse(
          data, AppUrl.registerEndPoint);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> loginApi(String email, String password) async {
    try {
      dynamic response = await _apiServices.getPostLoginApiResponse(
          AppUrl.loginEndPoint, email, password);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
