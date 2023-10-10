import 'package:flutter/material.dart';
import 'package:mvvm_signin_out/model/auth/user_model.dart';
//import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/utils/routes/routes_name.dart';
import 'package:mvvm_signin_out/view_model/user_view_model.dart';

class SplashServices {
  void checkAuthentication(BuildContext context) async {
    UserViewModel().checkUser().then((value) {
      if (value) {
        // context.read<UserViewModel>().getUser();

        Navigator.pushNamed(context, RoutesName.layout);
      } else {
        Navigator.pushNamed(context, RoutesName.login);
      }
    });
  }
}
