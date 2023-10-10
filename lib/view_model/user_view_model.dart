//import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import '../model/auth/user_model.dart';

final loginprovider = ChangeNotifierProvider(
  (ref) => UserViewModel(),
);

class UserViewModel extends ChangeNotifier {
  var userdata;

  Future<dynamic> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    final String? user = sp.getString('user_session');

    userdata = jsonDecode(user!);
    //print(userdata);
    notifyListeners();
    return userdata;
  }

  Future<bool> checkUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    if (sp.containsKey("user_session")) {
      return true;
    }
    return false;
  }

  Future<dynamic> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    userdata = sp.clear();
    notifyListeners();
    return userdata;
  }
}
