import 'package:isar/isar.dart';
import 'package:fotoflu/models/sesion.dart';

part 'grupo.g.dart';

@collection
class Grupo {
  Id id = Isar.autoIncrement;

  String? nombre;

  final sesion = IsarLink<Sesion>();
}
