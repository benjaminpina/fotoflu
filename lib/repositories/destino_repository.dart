import 'package:fotoflu/db/isar_service.dart';
import 'package:fotoflu/models/destino.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

class DestinoRepository extends GetxController {
  final isar = IsarService().isar;

  final destinos = <Destino>[];

  @override
  void onInit() {
    super.onInit();

    final allDestinos = isar.destinos.where().findAllSync();

    if (allDestinos.isEmpty) {
      // Valores por defecto
      final defaultDestinos = [
        Destino()..nombre = 'jpg',
        Destino()..nombre = 'selectas',
        Destino()..nombre = 'procesadas',
        Destino()..nombre = 'retocadas',
        Destino()..nombre = 'selladas',
        Destino()..nombre = 'achicadas',
      ];

      // Agregar valores por defecto a la colección
      isar.writeTxnSync(() {
        isar.destinos.putAllSync(defaultDestinos);
      });

      // Actualizar la lista observable
      destinos.addAll(defaultDestinos);
    } else {
      destinos.addAll(allDestinos);
    }
  }

  Future<void> addDestino(String nombre) async {
    if (nombre.isEmpty) {
      return;
    }

    if (!destinos.any((d) => d.nombre == nombre)) {
      final destino = Destino()..nombre = nombre;

      await isar.writeTxn(() async {
        await isar.destinos.put(destino);
      });
      destinos.add(destino);
    }
  }

  Future<void> removeDestino(String nombre) async {
    final destino = destinos.firstWhereOrNull((d) => d.nombre == nombre);

    if (destino != null) {
      await isar.writeTxn(() async {
        await isar.destinos.delete(destino.id);
      });

      destinos.remove(destino);
    }
  }
}
