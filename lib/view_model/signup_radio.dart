import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final RegisterVmProvider =
    ChangeNotifierProvider<RegisterVm>((ref) => RegisterVm());

class RegisterVm extends ChangeNotifier {
  bool isChecked = false;
  String? gender = "male";

  void onChecked() {
    if (isChecked) {
      isChecked = false;
    } else {
      isChecked = true;
    }
    notifyListeners();
  }

  void onGenderSelect(String gen) {
    gender = gen;
    notifyListeners();
  }
}
