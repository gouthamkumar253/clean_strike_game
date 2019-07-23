import 'package:clean_strike/models/game.dart';
import 'package:clean_strike/models/player.dart';
import 'package:clean_strike/views/game_over.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CleanStrike extends StatefulWidget {
  const CleanStrike({Key key, this.gameType}) : super(key: key);

  final int gameType;

  @override
  _CleanStrikeState createState() => _CleanStrikeState();
}

class _CleanStrikeState extends State<CleanStrike> {
  int play1 = 1;
  int winner;
  Game gameObject = Game();
  Player player1 = Player();
  Player player2 = Player();
  bool gameOver = true;
  bool operationSuccess = false;

  void showToast(String toastMessage) {
    Toast.show(
      toastMessage,
      context,
      backgroundRadius: 14,
      gravity: Toast.BOTTOM,
      duration: 2,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  void setPlayer(int winner) {
    print(winner);
    if (!gameOver && winner < 0)
      switch (play1) {
        case 1:
          play1 += 1;
          break;
        case 2:
          play1 = 1;
          break;
      }
    else {
      Navigator.of(context).push(
        PageRouteBuilder<Widget>(
          opaque: false,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondary) =>
              GameOver(winner: winner),
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (BuildContext context, Animation<double> anim,
                  Animation<double> secondaryAnim, Widget child) =>
              FadeTransition(
            child: child,
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(anim),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clean Strike',
          style: TextStyle(fontSize: 32),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Clean Strike!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 75,
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Colors.black,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Black Coins Left',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                gameObject.getBlackCoins().toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.red,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Red Coins Left',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                gameObject.getRedCoins().toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Player 1',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                player1.getScore().toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          '-',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 50,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Player 2',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              player2.getScore().toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                            child: Column(
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                setState(
                                  () {
                                    operationSuccess = gameObject.strike(
                                        player1, player2, play1);
                                    if (operationSuccess)
                                      showToast(
                                          'Player $play1 pockets a black coin');
                                    else
                                      showToast(
                                          'Invalid Move.No more black coins');

                                    gameOver = gameObject.isGameOver();
                                    winner =
                                        gameObject.didWin(player1, player2);
                                    setPlayer(winner);
                                  },
                                );
                              },
                              color: Colors.blue,
                              child: Text(
                                '1',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 32),
                              ),
                            ),
                            Text(
                              'Strike',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      operationSuccess = gameObject.multiStrike(
                                          player1, player2, play1);
                                      if (operationSuccess)
                                        showToast(
                                            'Player $play1 pockets 2 black coins');
                                      else
                                        showToast(
                                            'Invalid Move.No sufficient black boins');
                                      gameOver = gameObject.isGameOver();

                                      winner =
                                          gameObject.didWin(player1, player2);
                                      setPlayer(winner);
                                    },
                                  );
                                },
                                color: Colors.blue,
                                child: Text(
                                  '2',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 32),
                                ),
                              ),
                              Text(
                                'Multi Strike',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      operationSuccess = gameObject.redStrike(
                                          player1, player2, play1);
                                      if (operationSuccess)
                                        showToast(
                                            'Player $play1 pockets a red coin');
                                      else
                                        showToast(
                                            'Invalid Move.No more red coins');
                                      gameOver = gameObject.isGameOver();

                                      winner =
                                          gameObject.didWin(player1, player2);
                                      setPlayer(winner);
                                    },
                                  );
                                },
                                color: Colors.blue,
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 32),
                                ),
                              ),
                              Text(
                                'Red Strike',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      gameObject.strikerStrike(
                                          player1, player2, play1);
                                      showToast(
                                          'Player $play1 pockets the striker');
                                      gameOver=false;
                                      setPlayer(-1);
                                    },
                                  );
                                },
                                color: Colors.blue,
                                child: Text(
                                  '4',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 32),
                                ),
                              ),
                              Text(
                                'Striker Strike',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      gameObject.defunctCoin(
                                          player1, player2, play1);
                                      gameOver=false;

                                      showToast(
                                          'Player $play1 throws the coin out of the board');
                                      setPlayer(-1);
                                    },
                                  );
                                },
                                color: Colors.blue,
                                child: Text(
                                  '5',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 32),
                                ),
                              ),
                              Text(
                                'Defunct Coin',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      setPlayer(-1);
                                      gameOver=false;
                                      showToast('Player $play1 makes a pass');
                                    },
                                  );
                                },
                                color: Colors.blue,
                                child: Text(
                                  '6',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 32),
                                ),
                              ),
                              Text(
                                'None',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Card(
                elevation: 2,
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Player $play1\'s Turn',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
