import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GaleriaController extends GetxController {
  final PageController pageController = PageController();

  var images = <File>[].obs;
  var currentPage = 0.0.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPage.value = pageController.page ?? 0;
    });
    loadImages();
  }

  void loadImages() async {
    try {
      final imageDir = Directory(
        // '/home/benjamin/Imágenes/ninfas/Seleccion/achicadas',
        '/home/benjamin/Documentos/Llaves',
      );
      if (await imageDir.exists()) {
        final imageFiles = imageDir.listSync().whereType<File>().toList();
        if (imageFiles.isEmpty) {
          errorMessage.value = 'No se encontraron imágenes en el directorio.';
        } else {
          images.addAll(imageFiles);
        }
      } else {
        errorMessage.value = 'El directorio no existe.';
      }
    } catch (e) {
      errorMessage.value = 'Error al cargar las imágenes: $e';
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
