import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fotoflu/controllers/storage_controller.dart';
import 'package:fotoflu/repositories/destino_repository.dart';

class OpcionesController extends GetxController {
  final storage = Get.find<StorageController>();
  final destinoRepository = Get.find<DestinoRepository>();
  final extRawController = TextEditingController();

  final dirs = <String>[].obs;
  final selectedRow = Rxn<int>();

  final opcionesDestino = <DropdownMenuItem<int>>[].obs;
  final selDestinoJPG = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    _getDirs();
    selectedRow.value = null;
    extRawController.text = storage.extRaw;
    _loadDestinos();
  }

  void _getDirs() {
    dirs.clear();
    dirs.addAll(destinoRepository.destinos.map((d) => d.nombre ?? ''));
  }

  void _loadDestinos() {
    final destinos = destinoRepository.destinos;
    opcionesDestino.value =
        destinos
            .map(
              (destino) => DropdownMenuItem<int>(
                value: destino.id,
                child: Text(destino.nombre ?? ''),
              ),
            )
            .toList();

    selDestinoJPG.value = storage.destJpg;
    if (opcionesDestino.isNotEmpty && selDestinoJPG.value == -1) {
      selDestinoJPG.value = opcionesDestino.first.value!;
    }
  }

  void addDir(String? dir) async {
    if (dir == null || dir.isEmpty) {
      return;
    }
    if (!dirs.contains(dir)) {
      await destinoRepository.addDestino(dir);
      _getDirs();
    }
  }

  void removeDir(int index) async {
    await destinoRepository.removeDestino(dirs[index]);
    _getDirs();
  }

  void updateDir(int index, String dir) async {
    final nombre = dirs[index];
    await destinoRepository.updateDestino(nombre, dir);
    _getDirs();
  }

  void updateStorage() {
    storage.extRaw = extRawController.text;
    storage.destJpg = selDestinoJPG.value;
  }
}
