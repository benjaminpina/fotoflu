import 'package:fotoflu/controllers/galeria_controller.dart';
import 'package:fotoflu/controllers/home_controller.dart';
import 'package:fotoflu/controllers/panel_inferior_controller.dart';
import 'package:get/get.dart';
import 'package:fotoflu/controllers/panel_lateral_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => PanelLateralController());
    Get.lazyPut(() => PanelInferiorController());
    Get.lazyPut(() => GaleriaController());
  }
}
