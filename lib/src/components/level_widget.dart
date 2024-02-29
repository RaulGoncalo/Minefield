// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LevelWidget extends StatelessWidget {
  final String value;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;

  const LevelWidget({
    Key? key,
    required this.value,
    this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      items: items,
      onChanged: onChanged,
    );
  }
}
