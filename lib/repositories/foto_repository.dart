import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:fotoflu/db/isar_service.dart';
import 'package:fotoflu/models/sesion.dart';
import 'package:fotoflu/models/grupo.dart';
import 'package:fotoflu/models/foto.dart';

class FotoRepository extends GetxController {
  final isar = IsarService().isar;

  Future<List<Foto>> getFotosBySesionId(int sesionId) async {
    final fotos =
        isar.fotos.where().filter().sesion((q) {
          return q.idEqualTo(sesionId);
        }).findAllSync();

    return fotos;
  }

  Future<List<Foto>> getFotosByGrupoId(int grupoId) async {
    final fotos =
        isar.fotos.where().filter().grupo((q) {
          return q.idEqualTo(grupoId);
        }).findAllSync();

    return fotos;
  }

  Future<void> addFoto(String nombre, Grupo grupo, Sesion sesion) async {
    if (nombre.isEmpty) {
      return;
    }

    final foto =
        Foto()
          ..nombre = nombre
          ..grupo.value = grupo
          ..sesion.value = sesion;

    await isar.writeTxn(() async {
      await isar.fotos.put(foto);
      await foto.grupo.save();
      await foto.sesion.save();
    });
  }

  Future<void> updateFotoGrupo(int id, Grupo grupo) async {
    await isar.writeTxn(() async {
      final foto = await isar.fotos.get(id);

      if (foto != null) {
        foto.grupo.value = grupo;
        await isar.fotos.put(foto);
        await foto.grupo.save();
      } else {
        return;
      }
    });
  }
}
