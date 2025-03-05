import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:fotoflu/controllers/storage_controller.dart';
import 'package:fotoflu/repositories/destino_repository.dart';

class OpcionesController extends GetxController {
  final storage = Get.find<StorageController>();
  final destinosController = Get.find<DestinoRepository>();
  final extRawController = TextEditingController();

  final dirs = <String>[].obs;
  final selectedRow = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
    _getDirs();
    selectedRow.value = null;
    extRawController.text = storage.extRaw;
  }

  void _getDirs() {
    dirs.clear();
    dirs.addAll(destinosController.destinos.map((d) => d.nombre ?? ''));
  }

  void addDir(String? dir) async {
    if (dir == null || dir.isEmpty) {
      return;
    }
    if (!dirs.contains(dir)) {
      await destinosController.addDestino(dir);
      _getDirs();
    }
  }

  void removeDir(int index) async {
    await destinosController.removeDestino(dirs[index]);
    _getDirs();
  }

  void updateDir(int index, String dir) async {
    final nombre = dirs[index];
    await destinosController.updateDestino(nombre, dir);
    _getDirs();
  }

  void updateStorage() {
    storage.extRaw = extRawController.text;
  }
}
