import 'package:flutter_test/flutter_test.dart';
import 'package:minefield/src/models/game_board_model.dart';

void main() {
  test('Ganhar Jogo', () {
    GameBoardModel board = GameBoardModel(
      rows: 2,
      columns: 2,
      quantityBombs: 0,
    );

    board.fields[0].undermine();
    board.fields[3].undermine();

    //Jogando
    board.fields[0].toggleMarking();
    board.fields[1].open();
    board.fields[2].open();
    board.fields[3].toggleMarking();

    expect(board.resolved, true);
  });
}
