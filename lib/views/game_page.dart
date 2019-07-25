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
  int _currentPlayer = 1;
  int _winner;
  bool _actionSuccess = false;
  final Game _gameObject = Game();

  void _showToast(String toastMessage) {
    Toast.show(
      toastMessage,
      context,
      backgroundRadius: 14,
      gravity: Toast.BOTTOM,
      duration: 3,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  void _performAction(int action, {int scenario = 0}) {
    _currentPlayer = _gameObject.getCurrentPlayer();
    if (action == 2 || action == 5)
      _actionSuccess = _gameObject.actions(action, scenario: scenario);
    else
      _actionSuccess = _gameObject.actions(action);

    _winner = _gameObject.gameWinner();
    _predictWinner(_winner);
  }

  void _showDialog(int action) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Scenario'),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(
                    () {
                      _performAction(action, scenario: 1);

                      if (_actionSuccess)
                        action == 2
                            ? _showToast(
                                'Player $_currentPlayer pockets 2 black coins')
                            : _showToast(
                                'Player $_currentPlayer throws a black coin out of board');
                      else
                        _showToast('Invalid Move.No sufficient black coins');
                    },
                  );
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      action == 2 ? 'Black-Black' : 'Black',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox(
                  width: 20,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(
                    () {
                      _performAction(action, scenario: 2);

                      if (_actionSuccess)
                        action == 2
                            ?_showToast(
                            'Player $_currentPlayer pockets a black coin and a red coin\nBlack coin is returned to the board.'):
                      _showToast('Player $_currentPlayer throws the red coin out of board');
                      else
                        _showToast('Invalid Move.No sufficient coins');
                    },
                  );
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: action == 2
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Colors.black,
                              Colors.red,
                            ],
                            stops: const <double>[0.5, 0.5],
                          )
                        : LinearGradient(
                            colors: <Color>[Colors.red, Colors.redAccent],
                          ),
                  ),
                  child: Center(
                    child: Text(
                      action == 2 ? 'Black-Red' : 'Red',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _predictWinner(int _winner) {
    if (_winner >= 0) {
      Navigator.of(context).push(
        PageRouteBuilder<Widget>(
          opaque: false,
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondary) =>
              GameOver(winner: _winner),
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
        title: const Text(
          'Clean Strike',
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Card(
                        elevation: 2,
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Player ${_gameObject.getCurrentPlayer()}\'s Turn',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
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
                            color: Colors.black,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Black Coins \nLeft',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _gameObject.getBlackCoins().toString(),
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
                                    'Red Coins\n Left',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _gameObject.getRedCoins().toString(),
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
                                    _gameObject.getPlayerScore(0).toString(),
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
                                  _gameObject.getPlayerScore(1).toString(),
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
                    height: 25,
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Wrap(
                          runSpacing: 15,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          _performAction(1);
                                          if (_actionSuccess)
                                            _showToast(
                                                'Player $_currentPlayer pockets a black coin');
                                          else
                                            _showToast(
                                                'Invalid Move.No more black coins');
                                        },
                                      );
                                    },
                                    color: Colors.blue,
                                    child: Text(
                                      'Strike',
                                      textAlign: TextAlign.center,

                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () {
                                      if (_gameObject.getRedCoins() == 1 &&
                                          _gameObject.getBlackCoins() != 0)
                                        _showDialog(2);
                                      else
                                        setState(() {
                                          _performAction(2, scenario: 1);

                                          if (_actionSuccess)
                                            _showToast(
                                                'Player $_currentPlayer pockets 2 black coins');
                                          else
                                            _showToast(
                                                'Invalid Move.No sufficient black boins');
                                        });
                                    },
                                    color: Colors.blue,
                                    child: Text(
                                      'Multi Strike',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          _performAction(3);

                                          if (_actionSuccess)
                                            _showToast(
                                                'Player $_currentPlayer pockets a red coin');
                                          else
                                            _showToast(
                                                'Invalid Move.No more red coins');
                                        },
                                      );
                                    },
                                    color: Colors.blue,
                                    child: Text(
                                      'Red Strike',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          _performAction(4);

                                          if (_gameObject
                                              .isFoul(_currentPlayer))
                                            _showToast(
                                                'Player $_currentPlayer pockets the striker coin.You will lose an additional point since you have 3 fouls');
                                          else
                                            _showToast(
                                                'Player $_currentPlayer pockets the striker');
                                        },
                                      );
                                    },
                                    color: Colors.blue,
                                    child: Text(
                                      'Striker Strike',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () {
                                      if (_gameObject.getRedCoins() != 0 &&
                                          _gameObject.getBlackCoins() != 0)
                                        _showDialog(5);
                                      else if (_gameObject.getRedCoins() ==
                                          0)
                                        setState(
                                          () {
                                            _performAction(5, scenario: 1);

                                            if (_actionSuccess)
                                              _showToast(
                                                  'Player $_currentPlayer pockets 2 black coins');
                                            else
                                              _showToast(
                                                  'Invalid Move.No sufficient black boins');
                                          },
                                        );
                                      else {
                                        setState(() {
                                          _performAction(2, scenario: 2);

                                          if (_actionSuccess)
                                            _showToast(
                                                'Player $_currentPlayer pockets 2 black coins');
                                          else
                                            _showToast(
                                                'Invalid Move.No sufficient black boins');
                                        });
                                      }
                                    },
                                    color: Colors.blue,
                                    child: Text(
                                      'Defunct Coin',
                                      textAlign: TextAlign.center,

                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          _performAction(6);

                                          if (_gameObject
                                              .isIdle(_currentPlayer))
                                            _showToast(
                                                'Player $_currentPlayer makes an idle pass. You will lose an additional point since you haven\'t pocketed a coin for 3 successive turns');
                                          else
                                            _showToast(
                                                'Player $_currentPlayer makes an idle pass');
                                        },
                                      );
                                    },
                                    color: Colors.blue,
                                    child: Text(
                                      'Miss',
                                      textAlign: TextAlign.center,

                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
