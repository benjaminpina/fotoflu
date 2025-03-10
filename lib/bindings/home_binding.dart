import 'package:fotoflu/repositories/foto_repository.dart';
import 'package:fotoflu/repositories/grupo_repository.dart';
import 'package:fotoflu/repositories/sesion_repository.dart';
import 'package:get/get.dart';
import 'package:fotoflu/controllers/galeria_controller.dart';
import 'package:fotoflu/controllers/home_controller.dart';
import 'package:fotoflu/controllers/panel_inferior_controller.dart';
import 'package:fotoflu/repositories/destino_repository.dart';
import 'package:fotoflu/controllers/panel_lateral_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => PanelLateralController());
    Get.lazyPut(() => PanelInferiorController());
    Get.lazyPut(() => GaleriaController());
    Get.put(DestinoRepository(), permanent: true);
    Get.put(SesionRepository(), permanent: true);
    Get.put(GrupoRepository(), permanent: true);
    Get.put(FotoRepository(), permanent: true);
  }
}
