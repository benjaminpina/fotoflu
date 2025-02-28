import 'package:get/get.dart';
import 'package:fotoflu/controllers/storage_controller.dart';

class OpcionesController extends GetxController {
  final storage = Get.find<StorageController>();

  final dirs = <String>[].obs;
  final selectedRow = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
    dirs.value = storage.dirs;
    selectedRow.value = null;
  }

  void addDir(String? dir) {
    if (dir == null || dir.isEmpty) {
      return;
    }
    if (!dirs.contains(dir)) {
      dirs.add(dir);
    }
  }

  void removeDir(int index) {
    dirs.removeAt(index);
  }

  void updateDir(int index, String dir) {
    dirs[index] = dir;
  }

  void updateDirs() {
    storage.dirs = dirs.toList();
  }
}
