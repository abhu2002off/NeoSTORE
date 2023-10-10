import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  String quantity;
  Dropdown({super.key, required this.quantity});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  late String dropdownvalue;
  void initState() {
    super.initState();
    dropdownvalue = widget.quantity ?? '1';
  }

  List<String> items = ['1', '2', '3', '4', '5', '6', '7'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: dropdownvalue,
        items: items.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownvalue = newValue!;
          });
        });
  }
}
