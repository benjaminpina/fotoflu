import 'dart:io';
import 'package:get/get.dart';

class GaleriaController extends GetxController {
  var images = <File>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadImages();
  }

  void loadImages() async {
    final imageDir = Directory(
      '/home/benjamin/Imágenes/ninfas/Seleccion/achicadas',
    );
    if (await imageDir.exists()) {
      final imageFiles = imageDir.listSync().whereType<File>().toList();
      images.addAll(imageFiles);
    }
  }
}
