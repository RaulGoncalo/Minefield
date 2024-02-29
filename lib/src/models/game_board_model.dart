import 'dart:math';

import 'field_model.dart';

class GameBoardModel {
  final int rows;
  final int columns;
  int quantityBombs;

  final List<FieldModel> _fields = [];

  GameBoardModel({
    required this.rows,
    required this.columns,
    required this.quantityBombs,
  }) {
    _createFields();
    _makingNeighbors();
    _minesRaffled();
  }

  void restartBoard() {
    for (var field in _fields) {
      field.restart();
    }
    _minesRaffled();
  }

  void revealBombs() {
    for (var field in _fields) {
      field.revealBomb();
    }
  }

  void _createFields() {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        _fields.add(FieldModel(row: r, column: c));
      }
    }
  }

  void _makingNeighbors() {
    for (var field in _fields) {
      for (var neighbor in _fields) {
        field.addNeighbor(neighbor);
      }
    }
  }

  void _minesRaffled() {
    int bombs = 0;

    if (quantityBombs > rows * columns) {
      return;
    }

    while (bombs < quantityBombs) {
      int numberRandom = Random().nextInt(_fields.length);

      if (!_fields[numberRandom].isMined) {
        bombs++;
        _fields[numberRandom].undermine();
      }
    }
  }

  List<FieldModel> get fields {
    return _fields;
  }

  bool get resolved {
    return _fields.every((element) => element.resolved);
  }
}
