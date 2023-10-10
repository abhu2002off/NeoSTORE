import 'package:flutter/material.dart';
import 'package:mvvm_signin_out/res/color.dart';
import 'package:mvvm_signin_out/res/components/heading.dart';
import 'package:mvvm_signin_out/view_model/services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    // UserViewModel().getUser().then((value) {
    //   if (value != null) {
    //     print("home");
    //   } else {
    //     print("login");
    //   }
    // });

    splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration:
                      const BoxDecoration(color: AppColor.backgroundredColor),
                  alignment: Alignment.center,
                  child: const CustomHeading(headingtitle: "NeoSTORE")),
            ),
          )
        ],
      ),
    );
  }
}
