import 'package:clean_strike/models/player.dart';

class Game {
  Game() {
    _blackCoins = 9;
    _redCoin = 1;
    _currentPlayer = 1;
    _players = <Player>[];
    _players.add(Player());
    _players.add(Player());
  }

  int _blackCoins;
  int _redCoin;
  int _score;
  int _currentPlayer;
  List<Player> _players;

  int getBlackCoins() {
    return _blackCoins;
  }

  int getRedCoins() {
    return _redCoin;
  }

  int getCurrentPlayer() {
    return _currentPlayer;
  }

  int getPlayerScore(int player) {
    return _players[player].getScore();
  }

  void _setPlayerScore(int score, int player) {
    _players[player].setScore(score);
  }

  bool _strike() {
    if (_blackCoins > 0) {
      _blackCoins -= 1;
      final int playerTurn = getCurrentPlayer();
      _score = getPlayerScore(playerTurn - 1);
      _setPlayerScore(_score + 1, playerTurn - 1);
      _players[playerTurn - 1].setIdleCount(0);
      return _changePlayer();
    }
    return false;
  }

  bool _multiStrike() {
    if (_blackCoins > 1) {
      _blackCoins -= 2;
      final int playerTurn = getCurrentPlayer();
      _score = getPlayerScore(playerTurn - 1);
      _setPlayerScore(_score + 2, playerTurn - 1);
      _players[playerTurn - 1].setIdleCount(0);
      return _changePlayer();
    }
    return false;

//    } else if (_blackCoins == 1 && _redCoin == 1) {
//      _blackCoins = 0;
//      _redCoin = 0;
//      switch (playerTurn) {
//        case 1:
//          {
//            _score = player1.getScore();
//            player1.setScore(_score + 4);
//            player1.getIsFoul() ? player1.setIsFoul(false) : null;
//            return true;
//          }
//        case 2:
//          {
//            _score = player2.getScore();
//            player2.setScore(_score + 4);
//            player2.getIsFoul() ? player2.setIsFoul(false) : null;
//            return true;
//          }
//      }
  }

  bool _redStrike() {
    if (_redCoin > 0) {
      _redCoin = 0;
      final int playerTurn = getCurrentPlayer();
      _score = getPlayerScore(playerTurn - 1);
      _setPlayerScore(_score + 3, playerTurn - 1);
      _players[playerTurn - 1].setIdleCount(0);

      return _changePlayer();
    }
    return false;
  }

  bool _strikerStrike() {
    final int playerTurn = getCurrentPlayer();
    _score = getPlayerScore(playerTurn - 1);
    _setPlayerScore(_score - 1, playerTurn - 1);
    _players[playerTurn - 1]
        .setFoulCount(_players[playerTurn - 1].getFoulCount() + 1);

    return _changePlayer();
  }

  bool _defunctCoin() {
    if (_blackCoins > 0) {
      _blackCoins -= 1;
      final int playerTurn = getCurrentPlayer();
      _score = getPlayerScore(playerTurn - 1);
      _setPlayerScore(_score - 2, playerTurn - 1);
      _players[playerTurn - 1]
          .setFoulCount(_players[playerTurn - 1].getFoulCount() + 1);
      return _changePlayer();
    }
    return false;

//    else if (_redCoin == 1) {
//      _redCoin = 0;
//      switch (playerTurn) {
//        case 1:
//          {
//            _score = player1.getScore();
//            player1.setScore(_score - 2);
//            if (!player1.getIsFoul()) {
//              player1.setIsFoul(true);
//            }
//            int foulCount = player1.getFoulCount();
//            player1.setFoulCount(foulCount++);
//            return true;
//          }
//        case 2:
//          {
//            _score = player2.getScore();
//            player2.setScore(_score - 2);
//            if (!player2.getIsFoul()) {
//              player2.setIsFoul(true);
//            }
//            int foulCount = player2.getFoulCount();
//            player2.setFoulCount(foulCount++);
//            return true;
//          }
//      }
//    }
  }

  bool _idlePass() {
    final int playerTurn = getCurrentPlayer();
    _players[playerTurn - 1]
        .setIdleCount(_players[playerTurn - 1].getIdleCount() + 1);
    _changePlayer();
    return true;
  }

  bool _changePlayer() {
    final int player = getCurrentPlayer();
    switch (player) {
      case 1:
        {
          _currentPlayer = 2;
          return true;
        }

      case 2:
        {
          _currentPlayer = 1;
          return true;
        }
    }
    return false;
  }

  bool isGameOver() {
    if (_blackCoins == 0 && _redCoin == 0)
      return true;
    else
      return false;
  }

  int didWin() {
    final bool endGame = _blackCoins == 0 && _redCoin == 0;

    final int player1score = _players[0].getScore();
    final int player2score = _players[1].getScore();
    if (player1score > player2score) {
      if (player1score - player2score >= 3 && player1score >= 5) {
        print('Player 1 Wins');
        return 1;
      } else {
        if (endGame)
          return 0;
        else
          return -1;
      }
    } else if (player2score >= player1score) {
      if (player2score - player1score >= 3 && player2score >= 5) {
        print('Player 2 wins');
        return 2;
      } else {
        if (endGame)
          return 0;
        else
          return -1;
      }
    }
  }

  bool isFoul(int currentPlayer) {
    _score = getPlayerScore(currentPlayer - 1);

    if (_players[currentPlayer - 1].getFoulCount() == 3) {
      print('Foul Detected');
      _setPlayerScore(_score - 1, currentPlayer - 1);
      _players[currentPlayer - 1].setFoulCount(0);
      return true;
    }
    return false;
  }

  bool isIdle(int currentPlayer) {
    _score = getPlayerScore(currentPlayer - 1);

    if (_players[currentPlayer - 1].getIdleCount() == 3) {
      print('Idle Detected');

      _setPlayerScore(_score - 1, currentPlayer - 1);
      _players[currentPlayer - 1].setIdleCount(0);
      return true;
    }
    return false;
  }

  bool actions(int action) {
    switch (action) {
      case 1:
        {
          return _strike();
        }
      case 2:
        {
          return _multiStrike();
        }
      case 3:
        {
          return _redStrike();
        }
      case 4:
        {
          return _strikerStrike();
        }
      case 5:
        {
          return _defunctCoin();
        }
      case 6:
        {
          return _idlePass();
        }
    }
    return false;
  }
}
