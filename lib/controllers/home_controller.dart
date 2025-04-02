import 'package:get/get.dart';
import 'package:fotoflu/services/files.dart';
import 'package:fotoflu/repositories/sesion_repository.dart';

enum AppState { inicial, explorando, sinImagenes }

class HomeController extends GetxController {
  final cambioIdSelected = Rxn<int>();
  final contCambios = 0.obs;
  final contSeleccionadas = 0.obs;
  final contSelPorGrupo = <int, int>{}.obs;
  final contParaBorrar = 0.obs;
  final appState = AppState.inicial.obs;

  final sesiones = Get.find<SesionRepository>();

  void setAppState(AppState value) {
    appState.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    _eliminaSesionesDirectorioBorrados();
  }

  void _eliminaSesionesDirectorioBorrados() async {
    final List<int> ids = [];
    final listaSesiones = await sesiones.getSesiones();

    for (final sesion in listaSesiones) {
      final existe = await directoryExists(sesion.carpeta ?? '/noexiste');
      if (!existe) {
        ids.add(sesion.id);
      }
    }

    for (final id in ids) {
      await sesiones.deleteSesion(id);
    }
  }
}
