import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fotoflu/controllers/storage_controller.dart';
import 'package:get/get.dart';

class GaleriaController extends GetxController {
  final storage = Get.find<StorageController>();
  final PageController pageController = PageController();

  var images = <File>[].obs;
  var dir = ''.obs;
  var currentPage = 0.0.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPage.value = pageController.page ?? 0;
    });
    dir.value = storage.dir;
    loadImages();
  }

  void loadImages() async {
    images.clear();
    try {
      final imageDir = Directory(dir.value);
      if (await imageDir.exists()) {
        final imageFiles = imageDir.listSync().whereType<File>().toList();
        final imageExtensions = [
          '.jpg',
          '.jpeg',
          '.png',
          '.gif',
          '.bmp',
          '.webp',
        ];

        final filteredImages =
            imageFiles.where((file) {
              final extension = file.path.split('.').last.toLowerCase();
              return imageExtensions.contains('.$extension');
            }).toList();

        if (filteredImages.isEmpty) {
          errorMessage.value = 'No se encontraron imágenes en el directorio.';
        } else {
          images.addAll(filteredImages);
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
    storage.dir = dir.value;
    super.onClose();
  }
}
