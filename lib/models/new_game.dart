import 'package:clean_strike/models/player.dart';

class Game {
  Game() {
    _blackCoins = 9;
    _redCoin = 1;
    _currentPlayer = 1;
    _player1 = Player();
    _player2 = Player();
  }

  int _blackCoins;
  int _redCoin;
  int _score;
  int _currentPlayer;
  Player _player1;
  Player _player2;

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
    switch (player) {
      case 1:
        return _player1.getScore();
      case 2:
        return _player2.getScore();
    }
  }

  void _setPlayerScore(int score, int player) {
    switch (player) {
      case 1:
        return _player1.setScore(score);
      case 2:
        return _player2.setScore(score);
    }
  }

  bool _strike() {
    if (_blackCoins > 0) {
      _blackCoins -= 1;
      final int playerTurn = getCurrentPlayer();

      switch (playerTurn) {
        case 1:
          {
            _score = getPlayerScore(playerTurn);
            _setPlayerScore(_score + 1, playerTurn);
            _currentPlayer = 2;
            return true;
          }
        case 2:
          {
            _score = getPlayerScore(playerTurn);
            _setPlayerScore(_score + 1, playerTurn);
            _currentPlayer = 1;
            return true;
          }
      }
    }
    return false;
  }

  bool _multiStrike() {
    if (_blackCoins > 1) {
      _blackCoins -= 2;
      final int playerTurn = getCurrentPlayer();

      switch (playerTurn) {
        case 1:
          {
            _score = getPlayerScore(playerTurn);
            _setPlayerScore(_score + 2, playerTurn);
            _currentPlayer = 2;
            return true;
          }
        case 2:
          {
            _score = getPlayerScore(playerTurn);
            _setPlayerScore(_score + 2, playerTurn);
            _currentPlayer = 1;
            return true;
          }
      }
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

      switch (playerTurn) {
        case 1:
          {
            _score = getPlayerScore(playerTurn);
            _setPlayerScore(_score + 3, playerTurn);
            _currentPlayer = 2;
            return true;
          }
        case 2:
          {
            _score = getPlayerScore(playerTurn);
            _setPlayerScore(_score + 3, playerTurn);
            _currentPlayer = 1;
            return true;
          }
      }
    }
    return false;
  }

  bool _strikerStrike() {
    final int playerTurn = getCurrentPlayer();

    switch (playerTurn) {
      case 1:
        {
          _score = getPlayerScore(playerTurn);
          _setPlayerScore(_score - 1, playerTurn);
          _currentPlayer = 2;
          return true;
        }
      case 2:
        {
          _score = getPlayerScore(playerTurn);
          _setPlayerScore(_score + 2, playerTurn);
          _currentPlayer = 1;
          return true;
        }
    }
    return false;
  }

  bool _defunctCoin() {
    if (_blackCoins > 0) {
      _blackCoins -= 1;
      final int playerTurn = getCurrentPlayer();

      switch (playerTurn) {
        case 1:
          {
            _score = getPlayerScore(playerTurn);
            _setPlayerScore(_score - 2, playerTurn);
            _currentPlayer = 2;
            return true;
          }
        case 2:
          {
            _score = getPlayerScore(playerTurn);
            _setPlayerScore(_score - 2, playerTurn);
            _currentPlayer = 1;
            return true;
          }
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

    final int player1score = _player1.getScore();
    final int player2score = _player2.getScore();
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
    } else if (player2score > player1score) {
      if (player2score - player1score >= 3 && player2score >= 5) {
        print('Player 2 wins');
        return 2;
      } else {
        if (endGame)
          return 0;
        else
          return -1;
      }
    } else {
      if (endGame)
        return 0;
      else
        return -1;
    }
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
          return _changePlayer();
        }
    }
    return false;
  }
}
