import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final MenuIconVmHomeProvider =
    ChangeNotifierProvider<MenuIconVmHome>((ref) => MenuIconVmHome());

class MenuIconVmHome extends ChangeNotifier {
  bool ismenuOpen = false;

  void onMenuIconPress() {
    if (ismenuOpen) {
      ismenuOpen = false;
    } else {
      ismenuOpen = true;
    }
    notifyListeners();
  }
}
