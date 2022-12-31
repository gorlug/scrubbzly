abstract class Block {
  final int x;
  final int y;

  Block({required this.x, required this.y});

  String toChar();
}

class EmptyBlock extends Block {
  EmptyBlock({required super.x, required super.y});

  @override
  String toChar() {
    return 'O';
  }
}

class WallBlock extends Block {
  WallBlock({required super.x, required super.y});

  @override
  String toChar() {
    return 'X';
  }
}

class EndBlock extends Block {
  EndBlock({required super.x, required super.y});

  @override
  String toChar() {
    return 'E';
  }
}

class StartABlock extends Block {
  StartABlock({required super.x, required super.y});

  @override
  String toChar() {
    return 'A';
  }
}

class StartBBlock extends Block {
  StartBBlock({required super.x, required super.y});

  @override
  String toChar() {
    return 'B';
  }
}
