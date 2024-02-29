import 'package:flutter/material.dart';
import 'package:minefield/src/models/field_model.dart';

class FieldWidget extends StatelessWidget {
  final FieldModel field;
  final void Function(FieldModel) onOpen;
  final void Function(FieldModel) onToggleMarking;

  const FieldWidget({
    super.key,
    required this.field,
    required this.onOpen,
    required this.onToggleMarking,
  });

  Widget _getImage() {
    int qtdMines = field.quantityMinesNeighborhood();

    if (field.isOpen && field.isMined && field.isExplosion) {
      return Image.asset('assets/images/bomba_0.jpeg');
    } else if (field.isOpen && field.isMined) {
      return Image.asset('assets/images/bomba_1.jpeg');
    } else if (field.isOpen) {
      return Image.asset('assets/images/aberto_$qtdMines.jpeg');
    } else if (field.isMarked) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onToggleMarking(field),
      child: _getImage(),
    );
  }
}
