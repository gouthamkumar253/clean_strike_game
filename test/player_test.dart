import 'package:test/test.dart';
import 'package:clean_strike/models/player.dart';

void main() {
  group('Initial Value', () {
    test('value should start at 0', () {
      expect(Player().getScore(), 0);
    });
    test('value should start at 0', () {
      expect(Player().getIdleCount(), 0);
    });
    test('value should start at 0', () {
      expect(Player().getFoulCount(), 0);
    });
  });
  group('Change Value', () {
    final Player player = Player();

    test('value should be changed', () {
      player.setScore(1);

      expect(player.getScore(), 1);
    });
    test('value should be changed', () {
      player.setIdleCount(1);

      expect(player.getIdleCount(), 1);
    });
    test('value should be changed', () {
      player.setFoulCount(1);

      expect(player.getFoulCount(), 1);
    });
  });
}
