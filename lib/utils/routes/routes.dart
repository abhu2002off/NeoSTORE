import 'package:flutter/material.dart';
import 'package:mvvm_signin_out/utils/routes/routes_name.dart';
import 'package:mvvm_signin_out/view/addCart_screen.dart';
import 'package:mvvm_signin_out/view/authentication/login_view.dart';
import 'package:mvvm_signin_out/view/authentication/signup_view.dart';
import 'package:mvvm_signin_out/view/layout_screen.dart';
import 'package:mvvm_signin_out/view/product_detail_screen.dart';
import 'package:mvvm_signin_out/view/product_screen.dart';
import 'package:mvvm_signin_out/view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.layout:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LayoutScreen());
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpView());
      case RoutesName.productlisting:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                ProductListing(data: settings.arguments));
      case RoutesName.productDetail:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                ProductDetail(data: settings.arguments));
      case RoutesName.addtocart:
        return MaterialPageRoute(
            builder: (BuildContext context) => AddCart(
                  data: settings.arguments,
                ));

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text('No route defined')),
          );
        });
    }
  }
}
