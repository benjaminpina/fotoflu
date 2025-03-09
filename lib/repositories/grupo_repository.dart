import 'package:fotoflu/models/grupo.dart';
import 'package:fotoflu/models/sesion.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:fotoflu/db/isar_service.dart';

class GrupoRepository extends GetxController {
  final isar = IsarService().isar;

  final grupos = <Grupo>[].obs;

  @override
  void onInit() {
    super.onInit();

    final allGrupos = isar.grupos.where().findAllSync();
    grupos.addAll(allGrupos);
  }

  Future<void> addGrupo(String nombre, Sesion sesion) async {
    if (nombre.isEmpty) {
      return;
    }

    if (!grupos.any((g) => g.nombre == nombre)) {
      final grupo =
          Grupo()
            ..nombre = nombre
            ..sesion.value = sesion;

      await isar.writeTxn(() async {
        await isar.grupos.put(grupo);
        await grupo.sesion.save();
      });
      grupos.add(grupo);
    }
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

    grupos.firstWhere((g) => g.id == id).nombre = nombre;
  }

  Future<void> deleteGrupo(int id) async {
    final grupo = grupos.firstWhereOrNull((g) => g.id == id);

    await isar.writeTxn(() async {
      await isar.grupos.delete(grupo!.id);
    });
    grupos.remove(grupo);
  }
}
