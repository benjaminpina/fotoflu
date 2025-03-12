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
        isar.fotos
            .where()
            .filter()
            .sesion((q) {
              return q.idEqualTo(sesionId);
            })
            .sortByNombre()
            .findAllSync();

    return fotos;
  }

  Future<List<Foto>> getFotosByGrupoId(int grupoId) async {
    final fotos =
        isar.fotos
            .where()
            .filter()
            .grupo((q) {
              return q.idEqualTo(grupoId);
            })
            .sortByNombre()
            .findAllSync();

    return fotos;
  }

  Future<void> addFoto(String nombre, Sesion sesion) async {
    if (nombre.isEmpty) {
      return;
    }

    final foto =
        Foto()
          ..nombre = nombre
          ..grupo.value = null
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

  Future<void> unselectFoto(int id) async {
    await isar.writeTxn(() async {
      final foto = await isar.fotos.get(id);

      if (foto != null) {
        foto.grupo.value = null;
        await isar.fotos.put(foto);
        await foto.grupo.save();
      } else {
        return;
      }
    });
  }
}
