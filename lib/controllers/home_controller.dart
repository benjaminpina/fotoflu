import 'package:get/get.dart';

enum AppState { inicial, explorando, sinImagenes }

class HomeController extends GetxController {
  final cambioIdSelected = Rxn<int>();
  final contCambios = 0.obs;
  final contSeleccionadas = 0.obs;
  final contParaBorrar = 0.obs;
  final appState = AppState.inicial.obs;

  void setAppState(AppState value) {
    appState.value = value;
  }
}
