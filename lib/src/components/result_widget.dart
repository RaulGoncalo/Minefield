// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:minefield/src/components/level_widget.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? won;
  final void Function()? onRestart;
  final String value;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;

  const ResultWidget({
    Key? key,
    required this.won,
    required this.onRestart,
    required this.value,
    this.items,
    this.onChanged,
  }) : super(key: key);

  Color _getCor() {
    if (won == null) {
      return const Color(0xFFFFEB3B);
    } else if (won!) {
      return const Color(0xFF81C784);
    } else {
      return const Color(0xFFE57373);
    }
  }

  IconData _getIcon() {
    if (won == null) {
      return Icons.sentiment_satisfied;
    } else if (won!) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LevelWidget(
              value: value,
              items: items,
              onChanged: onChanged,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                backgroundColor: _getCor(),
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: onRestart,
                  icon: Icon(
                    _getIcon(),
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
