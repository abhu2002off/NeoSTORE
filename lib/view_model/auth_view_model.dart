import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:mvvm_signin_out/model/auth/user_model.dart';
import 'package:mvvm_signin_out/repository/auth_repository.dart';
import 'package:mvvm_signin_out/utils/routes/routes_name.dart';
//import 'package:mvvm_signin_out/view_model/user_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utlis.dart';

final authViewModelProvider = ChangeNotifierProvider<AuthViewModel>((ref) {
  return AuthViewModel(AuthRepo: ref.read(repositoryProvider));
});

class AuthViewModel with ChangeNotifier {
  final AuthRepository AuthRepo;
  AuthViewModel({required this.AuthRepo});
  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setsignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

//  final showPassProvider = StateProvider<bool>((ref) => true);

  Future<void> loginApi(
      String email, String password, BuildContext context) async {
    AuthRepo.loginApi(email, password).then((value) async {
      final sharePref = await SharedPreferences.getInstance();

      sharePref.setString("user_session", jsonEncode(value));
      setLoading(false);
      Utils.flushBarErrorMessage("Login Successful", context);

      Navigator.pushNamed(context, RoutesName.layout);
      if (kDebugMode) {
        //print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setsignUpLoading(true);
    AuthRepo.signUpApi(data).then((value) {
      setsignUpLoading(false);
      Utils.flushBarErrorMessage("Sign Up Successful", context);
      Navigator.pushNamed(context, RoutesName.login);
      if (kDebugMode) {
        // print(value.toString());
      }
    }).onError((error, stackTrace) {
      setsignUpLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }
}
