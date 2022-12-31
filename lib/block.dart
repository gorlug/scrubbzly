mixin Block {
  String toChar();
}

class EmptyBlock with Block {
  @override
  String toChar() {
    return 'O';
  }
}

class WallBlock with Block {
  @override
  String toChar() {
    return 'X';
  }
}
