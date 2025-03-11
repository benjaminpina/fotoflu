import 'package:get/get.dart';

class HomeController extends GetxController {
  final cambioIdSelected = Rxn<int>();
  final contCambios = 0.obs;
  final contSeleccionadas = 0.obs;
  final contParaBorrar = 0.obs;
}
