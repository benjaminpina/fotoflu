import 'package:get/get.dart';
import 'package:fotoflu/controllers/opciones_controller.dart';

class OpcionesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OpcionesController());
  }
}
