
import 'package:tic_tac_toe_starter/gamelogic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test fullBoard", () {
    List<List<Token>> board = [
      [null, null, null],
      [null, null, null],
      [null, null, null]
    ];

    board[2][2] = Token.x;

    expect(fullBoard(board), false);

  });

}