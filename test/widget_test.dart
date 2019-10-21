
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

  test("test if nextTurn is changing when the board is draw", () {

    currentPlayer = Token.x;
    board = [
      [Token.x, Token.x, Token.x],
      [Token.x, Token.x, Token.x],
      [Token.x, Token.x, Token.x]
    ];
    nextTurn();
    expect(currentPlayer, Token.x);

  });

  test("testing getString 1 - draw", (){
    currentPlayer = Token.x;
    board = [
      [Token.x, Token.o, Token.x],
      [Token.o, Token.o, Token.x],
      [Token.x, Token.x, Token.o]
    ];

    expect(getCurrentStatus(),"draw");


  });

  test("testing getString 2 - O won", (){
    currentPlayer = Token.o;
    board = [
      [Token.x, Token.o, Token.x],
      [Token.o, Token.o, Token.x],
      [Token.x, Token.o, null]
    ];

    expect(getCurrentStatus(),"O won");


  });

  test("testing getString 3 - O move", (){
    currentPlayer = Token.x;
    board = [
      [Token.x, null, null],
      [null, null, null],
      [null, null, null]
    ];
    changePlayer(currentPlayer);

    expect(getCurrentStatus(),"Player O move");


  });

  test("testing getString 4 - X move", (){
    currentPlayer = Token.o;
    board = [
      [Token.x, Token.o, null],
      [null, null, null],
      [null, null, null]
    ];
    changePlayer(currentPlayer);

    expect(getCurrentStatus(),"Player X move");


  });


}