import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:fotoflu/db/isar_service.dart';
import 'package:fotoflu/models/sesion.dart';

class SesionRepository extends GetxController {
  final isar = IsarService().isar;

  final sesiones = <Sesion>[].obs;

  @override
  void onInit() {
    super.onInit();

    final allSesiones = isar.sesions.where().findAllSync();
    sesiones.addAll(allSesiones);
  }

  Future<void> addSesion(String carpeta) async {
    if (carpeta.isEmpty) {
      return;
    }

    if (!sesiones.any((s) => s.carpeta == carpeta)) {
      final sesion = Sesion()..carpeta = carpeta;

      await isar.writeTxn(() async {
        await isar.sesions.put(sesion);
      });
      sesiones.add(sesion);
    }
  }

  Future<void> deleteSesion(int id) async {
    final sesion = sesiones.firstWhereOrNull((s) => s.id == id);

    await isar.writeTxn(() async {
      await isar.sesions.delete(sesion!.id);
    });
    sesiones.remove(sesion);
  }
}
