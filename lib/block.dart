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

class EndBlock with Block {
  @override
  String toChar() {
    return 'E';
  }
}

class StartABlock with Block {
  @override
  String toChar() {
    return 'A';
  }
}

class StartBBlock with Block {
  @override
  String toChar() {
    return 'B';
  }
}
