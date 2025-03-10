import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:fotoflu/db/isar_service.dart';
import 'package:fotoflu/models/sesion.dart';
import 'package:fotoflu/models/grupo.dart';
import 'package:fotoflu/models/foto.dart';

class SesionRepository extends GetxController {
  final isar = IsarService().isar;

  Future<Sesion> addSesion(String carpeta) async {
    final sesionPrevia =
        await isar.sesions.filter().carpetaEqualTo(carpeta).findFirst();

    if (sesionPrevia == null) {
      final sesion = Sesion()..carpeta = carpeta;

      await isar.writeTxn(() async {
        await isar.sesions.put(sesion);
      });
      return sesion;
    }

    return sesionPrevia;
  }

  Future<Sesion?> getSesionByCarpeta(String carpeta) async {
    final sesion =
        await isar.sesions.filter().carpetaEqualTo(carpeta).findFirst();

    return sesion;
  }

  Future<void> deleteSesion(int id) async {
    final sesion = await isar.sesions.get(id);

    if (sesion == null) {
      return;
    }

    await isar.writeTxn(() async {
      // Eliminar todas las fotos y grupos de la sesión
      await isar.fotos.where().filter().sesion((q) {
        return q.idEqualTo(sesion.id);
      }).deleteAll();
      await isar.grupos.where().filter().sesion((q) {
        return q.idEqualTo(sesion.id);
      }).deleteAll();
      await isar.sesions.delete(sesion.id);
    });
  }
}
