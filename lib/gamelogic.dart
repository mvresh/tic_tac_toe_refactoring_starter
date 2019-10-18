

enum Token {
  x, o
}

List<List<Token>> board = List.generate(3, (_) => List.filled(3,null));

List<List<bool>> colorBoard = List.generate(3, (_) => List.filled(3,false));

bool legitMove(Token t) {
  return t == null && !winnerCheck(board);
}

String currentPlayer = 'Player X Move';

changePlayer(String x) {
  if (x == 'Player X Move') {
    currentPlayer = 'Player O Move';
  } else if (x == 'Player O Move') {
    currentPlayer = 'Player X Move';
  }
}

void gameReset() {
  board = List.generate(3, (_) => List.filled(3,null));
  colorBoard = List.generate(3, (_) => List.filled(3,false));
  currentPlayer = 'Player X Move';
}
bool fullBoard(List<List<Token>> board) {

  for (int i = 0; i < 3; i++) {
    if(board[i].contains(null)){
      return false;
    }
  }
  return true;
}

bool winnerCheck(List<List<Token>> board) {
  for (int i = 0; i < 3; i++) {
    if (board[i][0] == Token.x &&
        board[i][1] == Token.x &&
        board[i][2] == Token.x) {
      colorBoard[i][0] = true;
      colorBoard[i][1] = true;
      colorBoard[i][2] = true;
      return true;
    }
    if (board[0][i] == Token.x &&
        board[1][i] == Token.x &&
        board[2][i] == Token.x) {
      colorBoard[0][i] = true;
      colorBoard[1][i] = true;
      colorBoard[2][i] = true;
      return true;
    }
    if (board[i][0] == Token.o &&
        board[i][1] == Token.o &&
        board[i][2] == Token.o) {
      colorBoard[i][0] = true;
      colorBoard[i][1] = true;
      colorBoard[i][2] = true;
      return true;
    }
    if (board[0][i] == Token.o &&
        board[1][i] == Token.o &&
        board[2][i] == Token.o) {
      colorBoard[0][i] = true;
      colorBoard[1][i] = true;
      colorBoard[2][i] = true;
      return true;
    }
  }
  if (board[0][0] == Token.x &&
      board[1][1] == Token.x &&
      board[2][2] == Token.x) {
    colorBoard[0][0] = true;
    colorBoard[1][1] = true;
    colorBoard[2][2] = true;
    return true;
  }
  if (board[0][2] == Token.x &&
      board[1][1] == Token.x &&
      board[2][0] == Token.x) {
    colorBoard[0][2] = true;
    colorBoard[1][1] = true;
    colorBoard[2][0] = true;
    return true;
  }
  if (board[0][0] == Token.o &&
      board[1][1] == Token.o &&
      board[2][2] == Token.o) {
    colorBoard[0][0] = true;
    colorBoard[1][1] = true;
    colorBoard[2][2] = true;
    return true;
  }
  if (board[0][2] == Token.o &&
      board[1][1] == Token.o &&
      board[2][0] == Token.o) {
    colorBoard[0][2] = true;
    colorBoard[1][1] = true;
    colorBoard[2][0] = true;
    return true;
  } else {
    return false;
  }
}
