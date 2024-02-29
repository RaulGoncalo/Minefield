import 'package:flutter/material.dart';
import 'package:minefield/src/components/board_widget.dart';
import 'package:minefield/src/components/result_widget.dart';
import 'package:minefield/src/models/explosion_exception_model.dart';
import 'package:minefield/src/models/field_model.dart';
import 'package:minefield/src/models/game_board_model.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool? _won;
  GameBoardModel? _board;

  String _level = '1';

  final List<DropdownMenuItem<String>> _items = <String, String>{
    '1': 'Fácil',
    '2': 'Médio',
    '3': 'Difícil',
  }.entries.map((entry) {
    return DropdownMenuItem<String>(
      value: entry.key,
      child: Text(
        entry.value,
        style: const TextStyle(
          fontSize: 11,
          fontFamily: 'PressStart2P',
        ),
      ),
    );
  }).toList();

  GameBoardModel _getBoard(double width, double height) {
    if (_board == null) {
      int quantityColumns = 15;
      double boardSize = width / quantityColumns;
      int quantityRows = (height / boardSize).floor();

      _board = GameBoardModel(
        rows: quantityRows,
        columns: quantityColumns,
        quantityBombs: 15,
      );
    }

    return _board!;
  }

  void _restart() {
    setState(() {
      _won = null;
      _board!.restartBoard();
    });
  }

  void _open(FieldModel field) {
    if (_won != null) {
      return;
    }
    setState(() {
      try {
        field.open();
        if (_board!.resolved) {
          _won = true;
        }
      } on ExplosionExceptionModel {
        _won = false;
        _board!.revealBombs();
      }
    });
  }

  void _toggleMarking(FieldModel field) {
    if (_won != null) {
      return;
    }
    setState(() {
      field.toggleMarking();
      if (_board!.resolved) {
        _won = true;
      }
    });
  }

  void _onChangedLevel(String? level) {
    setState(() {
      _level = level!;
      if (_board != null) {
        _board!.quantityBombs =
            _level == '1' ? 15 : 15 * (int.parse(level) * 2);
      }
    });

    _restart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResultWidget(
        onRestart: _restart,
        won: _won,
        value: _level,
        items: _items,
        onChanged: _onChangedLevel,
      ),
      body: Container(
        color: Colors.grey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return BoardWidget(
              board: _getBoard(
                constraints.maxWidth,
                constraints.maxHeight,
              ),
              onOpen: _open,
              onToggleMarking: _toggleMarking,
            );
          },
        ),
      ),
    );
  }
}
