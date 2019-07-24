import 'package:test/test.dart';
import 'package:clean_strike/models/game.dart';

void main() {
  final Game gameObject = Game();
  group('Initial Values', () {
    test('Black Coins must be 9', () {
      expect(gameObject.getBlackCoins(), 9);
    });
    test('Red Coins must be 1', () {
      expect(gameObject.getRedCoins(), 1);
    });
    test('Initial player must be player 1', () {
      expect(gameObject.getCurrentPlayer(), 1);
    });
  });

  group('Strike Action', () {
    test('Strike action must return true', () {
      gameObject.setBlackCoins(9);
      expect(gameObject.actions(1), true);
      gameObject.setBlackCoins(1);
      expect(gameObject.actions(1), true);
    });
    test('Strike action must return false', () {
      gameObject.setBlackCoins(0);
      expect(gameObject.actions(1), false);
      gameObject.setBlackCoins(-1);
      expect(gameObject.actions(1), false);
    });
  });

  group('Multi Strike Action', () {
    test('Strike action must return true', () {
      gameObject.setBlackCoins(9);
      gameObject.setRedCoins(1);
      expect(gameObject.actions(2, scenario: 1), true);
      expect(gameObject.getBlackCoins(), 7);
      expect(gameObject.getRedCoins(), 1);
      expect(gameObject.actions(2, scenario: 2), true);
      expect(gameObject.getBlackCoins(), 6);
      expect(gameObject.getRedCoins(), 0);
      gameObject.setBlackCoins(1);
      gameObject.setRedCoins(1);
      expect(gameObject.actions(2,scenario: 2), true);
      expect(gameObject.getBlackCoins(), 0);
      expect(gameObject.getRedCoins(), 0);
    });
    test('Multi Strike action must return false', () {
      gameObject.setBlackCoins(0);
      gameObject.setRedCoins(0);
      expect(gameObject.actions(2, scenario: 1), false);
      expect(gameObject.actions(2, scenario: 2), false);
      gameObject.setRedCoins(1);
      expect(gameObject.actions(2, scenario: 1), false);
      expect(gameObject.actions(2, scenario: 2), false);
      gameObject.setBlackCoins(1);
      gameObject.setRedCoins(1);
      expect(gameObject.actions(2,scenario: 1), false);

    });
  });

  group('Red Strike', () {
    test('Red Strike action must return true', () {
      gameObject.setRedCoins(1);
      expect(gameObject.actions(3), true);
      gameObject.setRedCoins(-2);
      expect(gameObject.actions(3), false);
    });
    test('Red Strike action must return false', () {
      gameObject.setRedCoins(0);
      expect(gameObject.actions(3), false);
      gameObject.setRedCoins(4);
      expect(gameObject.actions(3), false);
    });
  });

  test('Striker Strike action must return only true always', () {
    gameObject.setBlackCoins(9);
    gameObject.setRedCoins(10);
    expect(gameObject.actions(4), true);
    gameObject.setBlackCoins(-2);
    expect(gameObject.actions(3), false);
  });

  group('Defunct Coin Action', () {
    test('Defunct Coin action must return true', () {
      gameObject.setBlackCoins(9);
      gameObject.setRedCoins(1);
      expect(gameObject.actions(5, scenario: 1), true);
      expect(gameObject.getBlackCoins(), 8);
      expect(gameObject.getRedCoins(), 1);
      expect(gameObject.actions(5, scenario: 2), true);
      expect(gameObject.getBlackCoins(), 8);
      expect(gameObject.getRedCoins(), 0);
      gameObject.setBlackCoins(1);
      gameObject.setRedCoins(1);
      expect(gameObject.actions(5,scenario: 2), true);
      expect(gameObject.getBlackCoins(), 1);
      expect(gameObject.getRedCoins(), 0);
    });
    test('Defunct Coin action must return false', () {
      gameObject.setBlackCoins(0);
      gameObject.setRedCoins(0);
      expect(gameObject.actions(5, scenario: 1), false);
      expect(gameObject.getBlackCoins(), 0);
      expect(gameObject.getRedCoins(), 0);

      expect(gameObject.actions(5, scenario: 2), false);
      expect(gameObject.getBlackCoins(), 0);
      expect(gameObject.getRedCoins(), 0);

      gameObject.setRedCoins(1);
      gameObject.setBlackCoins(0);
      expect(gameObject.actions(5, scenario: 1), false);
      expect(gameObject.getBlackCoins(), 0);
      expect(gameObject.getRedCoins(), 1);
      expect(gameObject.actions(5, scenario: 2), true);
      expect(gameObject.getBlackCoins(), 0);
      expect(gameObject.getRedCoins(), 0);
      gameObject.setBlackCoins(1);
      gameObject.setRedCoins(0);
      expect(gameObject.actions(5, scenario: 1), true);
      expect(gameObject.getBlackCoins(), 0);
      expect(gameObject.getRedCoins(), 0);
      expect(gameObject.actions(5, scenario: 2), false);
      expect(gameObject.getBlackCoins(), 0);
      expect(gameObject.getRedCoins(), 0);
    });
  });
}
