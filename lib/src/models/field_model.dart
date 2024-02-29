import 'explosion_exception_model.dart';

class FieldModel {
  final int row;
  final int column;
  final List<FieldModel> neighbors = [];

  bool _isOpen = false;
  bool _isMarked = false;
  bool _isMined = false;
  bool _isExplosion = false;

  FieldModel({
    required this.row,
    required this.column,
  });

  void addNeighbor(FieldModel neighbor) {
    final deltaRow = (row - neighbor.row).abs();
    final deltaColunm = (column - neighbor.column).abs();

    if (deltaRow == 0 && deltaColunm == 0) {
      return;
    }

    if (deltaRow <= 1 && deltaColunm <= 1) {
      neighbors.add(neighbor);
    }
  }

  void open() {
    if (_isOpen) {
      return;
    }

    _isOpen = true;

    if (_isMined) {
      _isExplosion = true;
      throw ExplosionExceptionModel();
    }

    if (safeNeighborhood) {
      for (var element in neighbors) {
        element.open();
      }
    }
  }

  void revealBomb() {
    if (_isMined) {
      _isOpen = true;
    }
  }

  void undermine() {
    _isMined = true;
  }

  void toggleMarking() {
    _isMarked = !_isMarked;
  }

  void restart() {
    _isOpen = false;
    _isMarked = false;
    _isMined = false;
    _isExplosion = false;
  }

  bool get isOpen {
    return _isOpen;
  }

  bool get isMarked {
    return _isMarked;
  }

  bool get isMined {
    return _isMined;
  }

  bool get isExplosion {
    return _isExplosion;
  }

  bool get resolved {
    bool minedAndMarked = isMined && isMarked;
    bool safetyAndOpen = !isMined && isOpen;

    return minedAndMarked || safetyAndOpen;
  }

  bool get safeNeighborhood {
    return neighbors.every((element) => !element._isMined);
  }

  int quantityMinesNeighborhood() {
    return neighbors.where((element) => element.isMined).length;
  }
}
