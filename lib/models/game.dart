import 'package:clean_strike/models/player.dart';

class Game {
  int _blackCoins = 9;
  int _redCoin = 1;
  int _score;

  int getBlackCoins() {
    return _blackCoins;
  }

  int getRedCoins() {
    return _redCoin;
  }

  bool strike(Player player1, Player player2, int playerTurn) {
    if (_blackCoins > 0) {
      _blackCoins -= 1;

      switch (playerTurn) {
        case 1:
          {
            _score = player1.getScore();
            player1.setScore(_score + 1);
            player1.getIsFoul() ? player1.setIsFoul(false) : null;
            return true;
          }
        case 2:
          {
            _score = player2.getScore();
            player2.setScore(_score + 1);
            player2.getIsFoul() ? player2.setIsFoul(false) : null;
            return true;
          }
      }
    }
    return false;
  }

  bool multiStrike(Player player1, Player player2, int playerTurn) {
    if (_blackCoins > 1) {
      _blackCoins -= 2;
      switch (playerTurn) {
        case 1:
          {
            _score = player1.getScore();
            player1.setScore(_score + 2);
            player1.getIsFoul() ? player1.setIsFoul(false) : null;
            return true;
          }
        case 2:
          {
            _score = player2.getScore();
            player2.setScore(_score + 2);
            player2.getIsFoul() ? player2.setIsFoul(false) : null;
            return true;
          }
      }
    }
    return false;
  }

  bool redStrike(Player player1, Player player2, int playerTurn) {
    if (_redCoin > 0) {
      _redCoin = 0;
      switch (playerTurn) {
        case 1:
          {
            _score = player1.getScore();
            player1.setScore(_score + 3);
            player1.getIsFoul() ? player1.setIsFoul(false) : null;
            return true;
          }
        case 2:
          {
            _score = player2.getScore();
            player2.setScore(_score + 2);
            player2.getIsFoul() ? player2.setIsFoul(false) : null;
            return true;
          }
      }
    }
    return false;
  }

  void strikerStrike(Player player1, Player player2, int playerTurn) {
    switch (playerTurn) {
      case 1:
        {
          _score = player1.getScore();
          player1.setScore(_score - 1);
          if (!player1.getIsFoul()) {
            player1.setIsFoul(true);
          }
          int foulCount = player1.getFoulCount();
          player1.setFoulCount(foulCount++);
          break;
        }
      case 2:
        {
          _score = player2.getScore();
          player2.setScore(_score - 1);
          if (!player2.getIsFoul()) {
            player2.setIsFoul(true);
          }
          int foulCount = player2.getFoulCount();
          player2.setFoulCount(foulCount++);
          break;
        }
    }
  }

  void defunctCoin(Player player1, Player player2, int playerTurn) {
    switch (playerTurn) {
      case 1:
        {
          _score = player1.getScore();
          player1.setScore(_score - 2);
          _blackCoins -= 2;
          if (!player1.getIsFoul()) {
            player1.setIsFoul(true);
          }
          int foulCount = player1.getFoulCount();
          player1.setFoulCount(foulCount++);
          break;
        }
      case 2:
        {
          _score = player2.getScore();
          player2.setScore(_score - 2);
          if (!player2.getIsFoul()) {
            player2.setIsFoul(true);
          }
          int foulCount = player2.getFoulCount();
          player2.setFoulCount(foulCount++);
          break;
        }
    }
  }

  bool isGameOver() {
    if (_blackCoins == 0 && _redCoin == 0)
      return true;
    else
      return false;
  }

  int didWin(Player player1, Player player2) {
    final bool endGame = _blackCoins == 0 && _redCoin == 0;

    final int player1score = player1.getScore();
    final int player2score = player2.getScore();
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
}
