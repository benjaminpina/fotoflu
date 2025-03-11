import 'package:isar/isar.dart';
import 'package:fotoflu/models/grupo.dart';
import 'package:fotoflu/models/sesion.dart';

part 'foto.g.dart';

@collection
class Foto {
  Id id = Isar.autoIncrement;

  String? nombre;
  bool paraBorrar = false;

  final sesion = IsarLink<Sesion>();
  final grupo = IsarLink<Grupo>();
}
