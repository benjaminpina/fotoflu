import 'package:isar/isar.dart';

part 'destino.g.dart';

@collection
class Destino {
  Id id = Isar.autoIncrement;

  String? nombre;
}
