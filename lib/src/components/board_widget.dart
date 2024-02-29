import 'package:flutter/material.dart';
import 'package:minefield/src/components/field_widget.dart';
import 'package:minefield/src/models/field_model.dart';
import 'package:minefield/src/models/game_board_model.dart';

class BoardWidget extends StatelessWidget {
  final GameBoardModel board;
  final void Function(FieldModel) onOpen;
  final void Function(FieldModel) onToggleMarking;

  const BoardWidget(
      {super.key,
      required this.board,
      required this.onOpen,
      required this.onToggleMarking});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: board.columns,
      children: board.fields.map((f) {
        return FieldWidget(
          field: f,
          onOpen: onOpen,
          onToggleMarking: onToggleMarking,
        );
      }).toList(),
    );
  }
}
