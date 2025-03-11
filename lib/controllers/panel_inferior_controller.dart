import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:fotoflu/controllers/home_controller.dart';
import 'package:fotoflu/repositories/foto_repository.dart';
import 'package:fotoflu/controllers/galeria_controller.dart';

class PanelInferiorController extends GetxController {
  final galeriaController = Get.find<GaleriaController>();
  final pageController = Get.find<GaleriaController>().pageController;
  final homeController = Get.find<HomeController>();
  final fotos = Get.find<FotoRepository>();

  final cambioEditing = TextEditingController();

  final currentPage = Rxn<double>();
  final maxImages = 0.obs;
  final nombreArchivo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    cambioEditing.text = '';
    currentPage.value = -1;
    pageController.addListener(_updatePageInfo);
  }

  void _updatePageInfo() {
    maxImages.value = galeriaController.maxImages.value;
    currentPage.value = pageController.page!;
    try {
      nombreArchivo.value =
          galeriaController.images[pageController.page!.toInt()].nombre ?? '';
      cambioEditing.text =
          galeriaController
              .images[pageController.page!.toInt()]
              .grupo
              .value
              ?.nombre ??
          '';
    } catch (e) {
      nombreArchivo.value = '';
      cambioEditing.text = '';
    }
  }

  void nextPage() {
    if (currentPage.value! < galeriaController.images.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentPage.value! > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToPage(int page) {
    pageController.jumpToPage(page);
    _updatePageInfo();
  }

  void seleccionar() async {
    final grupoId = homeController.cambioIdSelected.value;
    if (grupoId == null) return;
    final fotoId = galeriaController.images[pageController.page!.toInt()].id;
    await fotos.updateFotoGrupo(fotoId, grupoId);
    updateStats();
  }

  void updateStats() {
    homeController.contSeleccionadas.value =
        galeriaController.images
            .where((image) => image.grupo.value != null)
            .length;
    homeController.contParaBorrar.value =
        galeriaController.images.where((image) => image.paraBorrar).length;
  }
}
