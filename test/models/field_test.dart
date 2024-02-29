import 'package:flutter_test/flutter_test.dart';
import 'package:minefield/src/models/field_model.dart';

main() {
  group('Field test', () {
    test(
      'Abrir campo COM EXPLOSÃO',
      () {
        FieldModel f = FieldModel(column: 0, row: 0);
        f.undermine();

        expect(f.open, throwsException);
      },
    );

    test(
      'Abrir campo SEM EXPLOSÃO',
      () {
        FieldModel f = FieldModel(row: 0, column: 0);
        f.open();
        expect(f.isOpen, true);
      },
    );

    test(
      'Adicinar NÃO Vizinho',
      () {
        FieldModel f1 = FieldModel(row: 0, column: 0);
        FieldModel f2 = FieldModel(row: 1, column: 3);

        f1.addNeighbor(f2);

        expect(f1.neighbors.isEmpty, true);
      },
    );

    test(
      'Adicinar Vizinho',
      () {
        FieldModel f1 = FieldModel(row: 3, column: 3);
        FieldModel f2 = FieldModel(row: 3, column: 4);
        FieldModel f3 = FieldModel(row: 2, column: 2);
        FieldModel f4 = FieldModel(row: 4, column: 4);

        f1.addNeighbor(f2);
        f1.addNeighbor(f3);
        f1.addNeighbor(f4);

        expect(f1.neighbors.length, 3);
      },
    );

    test(
      'Minas na Vizinhança',
      () {
        FieldModel f1 = FieldModel(row: 3, column: 3);
        FieldModel f2 = FieldModel(row: 3, column: 4);
        f2.undermine();
        FieldModel f3 = FieldModel(row: 2, column: 2);
        FieldModel f4 = FieldModel(row: 4, column: 4);
        f4.undermine();

        f1.addNeighbor(f2);
        f1.addNeighbor(f3);
        f1.addNeighbor(f4);

        expect(f1.quantityMinesNeighborhood(), 2);
      },
    );
  });
}
