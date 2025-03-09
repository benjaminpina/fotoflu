import 'package:isar/isar.dart';

part 'sesion.g.dart';

@collection
class Sesion {
  Id id = Isar.autoIncrement;

  // Automáticamente toma el valor de la fecha yyyy-mm-dd
  String titulo = DateTime.now().toIso8601String().split('T').first;
  DateTime fecha = DateTime.now();
  String? carpeta;
}
