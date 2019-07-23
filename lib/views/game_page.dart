import 'package:clean_strike/models/game.dart';
import 'package:clean_strike/views/game_over.dart';
import 'package:flutter/material.dart';
import 'package:clean_strike/views/toast.dart';

class CleanStrike extends StatefulWidget {
  const CleanStrike({Key key, this.gameType}) : super(key: key);

  final int gameType;

  @override
  _CleanStrikeState createState() => _CleanStrikeState();
}

class _CleanStrikeState extends State<CleanStrike> {
  int currentPlayer = 1;
  int winner;
  bool actionSuccess = false;
  Game gameObject = Game();

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

  void losePoint() {}

  void predictWinner(int winner) {
    if (winner < 0)
      null;
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
      body: ListView(
        children: <Widget>[
          Padding(
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
                          'Let\'s Play!!!',
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
                                  gameObject.getPlayerScore(0).toString(),
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
                                gameObject.getPlayerScore(1).toString(),
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
                                      currentPlayer =
                                          gameObject.getCurrentPlayer();
                                      actionSuccess = gameObject.actions(1);

                                      if (actionSuccess)
                                        showToast(
                                            'Player $currentPlayer pockets a black coin');
                                      else
                                        showToast(
                                            'Invalid Move.No more black coins');

                                      winner = gameObject.didWin();
                                      predictWinner(winner);
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
                                        currentPlayer =
                                            gameObject.getCurrentPlayer();

                                        actionSuccess = gameObject.actions(2);
                                        if (actionSuccess)
                                          showToast(
                                              'Player $currentPlayer pockets 2 black coins');
                                        else
                                          showToast(
                                              'Invalid Move.No sufficient black boins');

                                        winner = gameObject.didWin();
                                        predictWinner(winner);
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
                                        currentPlayer =
                                            gameObject.getCurrentPlayer();

                                        actionSuccess = gameObject.actions(3);
                                        if (actionSuccess)
                                          showToast(
                                              'Player $currentPlayer pockets a red coin');
                                        else
                                          showToast(
                                              'Invalid Move.No more red coins');

                                        winner = gameObject.didWin();
                                        predictWinner(winner);
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
                                        currentPlayer =
                                            gameObject.getCurrentPlayer();
                                        gameObject.actions(4);

                                        if (gameObject.isFoul(currentPlayer))
                                          showToast(
                                              'Player $currentPlayer pockets the striker coin.You will lose an additional point since you have 3 fouls');
                                        else
                                          showToast(
                                              'Player $currentPlayer pockets the striker');
                                        predictWinner(-1);
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
                                        currentPlayer =
                                            gameObject.getCurrentPlayer();

                                        gameObject.actions(5);
                                        if (gameObject.isFoul(currentPlayer))
                                          showToast(
                                              'Player $currentPlayer throws a coin out of play. You will lose an additional point since you have 3 fouls');
                                        else
                                          showToast(
                                              'Player $currentPlayer throws a coin out of play');
                                        predictWinner(-1);
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
                                        currentPlayer =
                                            gameObject.getCurrentPlayer();
                                        gameObject.actions(6);

                                        if (gameObject.isIdle(currentPlayer))
                                          showToast(
                                              'Player $currentPlayer makes an idle pass. You will lose an additional point since you haven\'t pocketed a coin for 3 successive turns');
                                        else
                                          showToast(
                                              'Player $currentPlayer makes an idle pass');

                                        predictWinner(-1);
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
                          'Player ${gameObject.getCurrentPlayer()}\'s Turn',
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
        ],
      ),
    );
  }
}
