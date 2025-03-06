import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import "package:fotoflu/services/files.dart";
import 'package:fotoflu/repositories/destino_repository.dart';
import 'package:fotoflu/controllers/storage_controller.dart';

class PanelLateralController extends GetxController {
  final storage = Get.find<StorageController>();
  final destinos = Get.find<DestinoRepository>();

  final progress = 0.0.obs;
  final counter = ''.obs;
  final archOrigen = ''.obs;
  final archDestino = ''.obs;
  final title = 'Copiando...'.obs;

  void crearEstructura() async {
    final base = storage.dir;
    final List<String> dirs = [];

    for (final destino in destinos.destinos) {
      if (destino.nombre != null && destino.nombre!.isNotEmpty) {
        dirs.add(destino.nombre!);
      }
    }

    crearEstrcutura(base, dirs).then((value) async {
      if (value != null) {
        Get.snackbar('Error', value);
      } else {
        Get.snackbar('Info', 'Estructura de directorios creada');
      }
    });
  }

  Future<void> distribuirRawJpg(BuildContext context) async {
    final dirBase = storage.dir;
    final extRaw = storage.extRaw;

    final dirJpg =
        '$dirBase/${destinos.destinos.firstWhere((d) => d.id == storage.destJpg).nombre ?? ''}';
    final dirRaw =
        '$dirBase/${destinos.destinos.firstWhere((d) => d.id == storage.destRaw).nombre ?? ''}';

    final filesJpg = await filesByExt(dirBase, ['.jpg', '.jpeg']);
    final filesRaw = await filesByExt(dirBase, ['.$extRaw']);

    final filesJpgDest =
        filesJpg.map((f) => '$dirJpg/${p.basename(f)}').toList();
    final filesRawDest =
        filesRaw.map((f) => '$dirRaw/${p.basename(f)}').toList();

    title.value = 'Copiando archivos JPG...';
    progress.value = 0.0;
    for (var i = 0; i < filesJpg.length; i++) {
      final file = filesJpg[i];
      final dest = filesJpgDest[i];
      archOrigen.value = file;
      archDestino.value = dest;
      await copyFile(file, dest, preserveOriginal: false);
      counter.value = 'Copiando archivo ${i + 1} de ${filesJpg.length}';
      progress.value = (i + 1) / filesJpg.length;
    }

    title.value = 'Copiando archivos RAW...';
    progress.value = 0.0;
    for (var i = 0; i < filesRaw.length; i++) {
      final file = filesRaw[i];
      final dest = filesRawDest[i];
      archOrigen.value = file;
      archDestino.value = dest;
      await copyFile(file, dest, preserveOriginal: false);
      counter.value = 'Copiando archivo ${i + 1} de ${filesRaw.length}';
      progress.value = (i + 1) / filesRaw.length;
    }

    // Cerrar el diálogo que muestra el progreso
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    archDestino.value = '';
    archOrigen.value = '';
    title.value = '';
    progress.value = 0.0;
  }
}
