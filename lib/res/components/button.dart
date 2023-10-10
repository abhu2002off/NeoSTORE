import 'package:flutter/material.dart';

import '../color.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool loading;
  const CustomButton(
      {super.key,
      required this.title,
      required this.onPress,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: AppColor.whiteTextColor,
          minimumSize: const Size.fromHeight(50), // NEW
        ),
        onPressed: onPress,
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                title,
                style: const TextStyle(
                    color: AppColor.backgroundredColor, fontFamily: 'Gotham'),
              ));
  }
}
