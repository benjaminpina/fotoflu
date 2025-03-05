import 'package:get/get.dart';
import "package:fotoflu/services/files.dart";
import 'package:fotoflu/repositories/destino_repository.dart';
import 'package:fotoflu/controllers/storage_controller.dart';

class PanelLateralController extends GetxController {
  final storage = Get.find<StorageController>();
  final destinos = Get.find<DestinoRepository>();

  void crearEstructura() async {
    final base = storage.dir;
    final List<String> dirs = [];

    for (final destino in destinos.destinos) {
      if (destino.nombre != null && destino.nombre!.isNotEmpty) {
        dirs.add(destino.nombre!);
      }
    }

    crearEstrcutura(base, dirs).then((value) {
      if (value != null) {
        Get.snackbar('Error', value);
      } else {
        Get.snackbar('Info', 'Estructura de directorios creada');
      }
    });
  }
}
