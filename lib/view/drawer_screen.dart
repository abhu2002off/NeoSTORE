import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/res/color.dart';
import 'package:mvvm_signin_out/utils/routes/routes_name.dart';
import 'package:mvvm_signin_out/view/menu_item.dart';
import 'package:mvvm_signin_out/view_model/user_view_model.dart';

class DrawerScreen extends StatefulHookConsumerWidget {
  const DrawerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends ConsumerState<DrawerScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(loginprovider).getUser();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(loginprovider).userdata;
    // var userlogin = jsonDecode(user);
    Map<String, dynamic> userlogin = {};
    if (user != null) {
      userlogin = jsonDecode(user)["data"];
      print("My User:${userlogin["access_token"]}");
    }

    return Container(
        color: const Color.fromARGB(255, 58, 58, 56),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.only(right: 100),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, top: 8, bottom: 8, right: 8),
                      child: Text(
                        "${userlogin['first_name'] ?? " " + userlogin['last_name'] ?? " "}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Gotham',
                            color: AppColor.whiteTextColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5, top: 5, bottom: 5, right: 5),
                      child: Text(
                        "${userlogin['email']}",
                        style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Gotham',
                            color: AppColor.whiteTextColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  var data = {
                    "accesstoken": userlogin["access_token"].toString()
                  };
                  Navigator.pushNamed(context, RoutesName.addtocart,
                      arguments: data);
                },
                child: const Row(
                  children: [
                    Icon(Icons.shopping_cart),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text("My Cart",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)))
                  ],
                )),
            const MenuItem(title: 'Tables', icon: Icons.table_bar),
            const MenuItem(
                title: 'Sofas',
                icon: IconData(0xe242, fontFamily: 'MaterialIcons')),
            const MenuItem(title: 'Chairs', icon: Icons.chair),
            const MenuItem(
                title: 'Cupboards',
                icon: IconData(0xe35e, fontFamily: 'MaterialIcons')),
            const MenuItem(title: 'My Account', icon: Icons.person),
            const MenuItem(title: 'Store Locator', icon: Icons.location_on),
            const MenuItem(title: 'My Orders', icon: Icons.paste),
            GestureDetector(
                onTap: () {
                  ref.read(loginprovider).remove();
                  Navigator.pushNamed(context, RoutesName.login);
                },
                child: const Row(
                  children: [
                    Icon(Icons.logout,
                        color: Color.fromARGB(255, 241, 243, 245), size: 30),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text("Logout",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)))
                  ],
                ))
          ],
        ));
  }
}
