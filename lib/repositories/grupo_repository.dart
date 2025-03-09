import 'package:fotoflu/models/grupo.dart';
import 'package:fotoflu/models/sesion.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:fotoflu/db/isar_service.dart';

class GrupoRepository extends GetxController {
  final isar = IsarService().isar;

  Future<List<Grupo>> getGruposBySesionId(int sesionId) async {
    final grupos =
        isar.grupos.where().filter().sesion((q) {
          return q.idEqualTo(sesionId);
        }).findAllSync();

    return grupos;
  }

  Future<void> addGrupo(String nombre, Sesion sesion) async {
    if (nombre.isEmpty) {
      return;
    }

    final grupo =
        Grupo()
          ..nombre = nombre
          ..sesion.value = sesion;

    await isar.writeTxn(() async {
      await isar.grupos.put(grupo);
      await grupo.sesion.save();
    });
  }

  Future<void> updateGrupo(int id, String nombre) async {
    await isar.writeTxn(() async {
      final grupo = await isar.grupos.get(id);

      if (grupo != null) {
        grupo.nombre = nombre;
        await isar.grupos.put(grupo);
      } else {
        return;
      }
    });
  }

  Future<void> deleteGrupo(int id) async {
    await isar.writeTxn(() async {
      final grupo = await isar.grupos.get(id);

      if (grupo != null) {
        await isar.grupos.delete(grupo.id);
      } else {
        return;
      }
    });
  }
}
