import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const MenuItem({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Icon(icon,
                  color: const Color.fromARGB(255, 241, 243, 245), size: 30),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(title,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.white)))
            ],
          )),
    );
  }
}
