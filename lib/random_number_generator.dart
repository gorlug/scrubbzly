import 'dart:math';

mixin RandomNumberGenerator {
  int generateRandomNumber(int max);
}

class RandomNumberGeneratorImpl implements RandomNumberGenerator {
  const RandomNumberGeneratorImpl();

  @override
  int generateRandomNumber(int max) {
    return Random().nextInt(max);
  }
}

