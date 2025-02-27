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
}
