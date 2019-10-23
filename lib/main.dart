import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'gamelogic.dart';

//import 'package:flutter/animation.dart';

void main() {
  runApp(MaterialApp(
    home: TicTacToePage(),
  ));
}

class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> with SingleTickerProviderStateMixin {
  AnimationController textAnimationController;
  Widget createIcon(Token t) {
    if (t == Token.x) {
      return Icon(
        Icons.close,
        size: 85,
        color: Colors.white,
      );
    }
    if (t == Token.o) {
      return Icon(
        Icons.radio_button_unchecked,
        size: 75,
        color: Colors.white,
      );
    } else
      return null;
  }

  Color bgColor(int row, int col) {
    return colorBoard[row][col]
        ? Colors.yellow.withOpacity(0.4)
        : Colors.white30;
  }

  Widget ExpandedBox(int row, int col) {
    return Expanded(
      child: OneBox(
        buttonChild: createIcon(board[row][col]),
        colors: bgColor(row, col),
        onPressed: () {
          updateBox(row, col);
          setState(() {
            if(getCurrentStatus() == 'X won' || getCurrentStatus() == 'O won'){
              textAnimationController.forward();}
          });
          // print(controller.status);
        },
      ),
    );
  }

  Widget ExpandedRow(int row) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ExpandedBox(row, 0),
          ExpandedBox(row, 1),
          ExpandedBox(row, 2),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    textAnimationController = AnimationController(duration: Duration(milliseconds: 1000),vsync: this);

    textAnimationController.addStatusListener((AnimationStatus status){
      if(status == AnimationStatus.completed){
        textAnimationController.reverse();

      }
      else if (status == AnimationStatus.dismissed){
        textAnimationController.forward();

      }
    });

    textAnimationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD6AA7C),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/purple.jpg'), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Tic-Tac-Toe",
                  style: TextStyle(
                      fontSize: 45,
                      color: Colors.white,
                      fontFamily: 'Quicksand'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: getCurrentStatus() == 'X won' || getCurrentStatus() == 'O won'? Transform.scale(
                  scale: Tween(begin: 1.5,end: 3.0).transform(textAnimationController.value),
                  child: Text(
                    getCurrentStatus(),
                    style: TextStyle(
                        fontSize: 25,
                        color: ColorTween(begin: Colors.white,end:Colors.yellow).transform(textAnimationController.value),
                        fontFamily: 'Quicksand'),
                  )) : Text(
                    getCurrentStatus(),
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white.withOpacity(0.6),
                        fontFamily: 'Quicksand'),
                  ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                margin: EdgeInsets.all(6),
                child: Column(
                  children: <Widget>[
                    ExpandedRow(0),
                    ExpandedRow(1),
                    ExpandedRow(2),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: FlatButton(
                        color: Color(0xFF848AC1),
                        onPressed: () {
                          gameReset();
                          setState(() {});
                        },
                        child: Text("Reset",
                            style:
                                TextStyle(fontSize: 25, color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateBox(int r, int c) {
    if (legitMove(board[r][c])) {
      if (currentPlayer == Token.x) {
        board[r][c] = Token.x;
      } else {
        board[r][c] = Token.o;
      }
      nextTurn();
    }
  }
}

class OneBox extends StatefulWidget {
  final Widget buttonChild;
  final Function onPressed;
  final Color colors;

  OneBox(
      {this.buttonChild = const Text(''),
      this.onPressed,
      this.colors = Colors.white24});

  @override
  _OneBoxState createState() => _OneBoxState();
}

class _OneBoxState extends State<OneBox> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        value: 0.0, duration: Duration(milliseconds: 1000), vsync: this);
    //print(controller.status);
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation smoothAnimation =
        CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    //print(controller.status);
    return GestureDetector(
      onTap: () {
        //print(controller.status);
        widget.onPressed();
        controller.forward();
      },
      child: Container(
        alignment: Alignment.center,
        child: FadeTransition(
          opacity: controller,
          child: Transform.scale(
              scale: Tween(begin: 5.0, end: 1.0).transform(smoothAnimation.value),
              child: widget.buttonChild),
        ),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: widget.colors,
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
      ),
    );
  }
}
