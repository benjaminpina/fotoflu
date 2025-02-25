import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fotoflu/controllers/storage_controller.dart';
import 'package:get/get.dart';

class GaleriaController extends GetxController {
  final storage = Get.find<StorageController>();
  final PageController pageController = PageController();

  var images = <File>[].obs;
  var maxImages = 0.obs;
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
    _loadImages();
  }

  void _loadImages() async {
    images.clear();
    currentPage.value = 0;
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
          filteredImages.sort((a, b) => a.path.compareTo(b.path));
          images.addAll(filteredImages);
          maxImages.value = images.length;
        }
      } else {
        errorMessage.value = 'El directorio no existe.';
        await storage.resetDir();
        dir.value = storage.dir;
        maxImages.value = 0;
      }
    } catch (e) {
      errorMessage.value = 'Error al cargar las imágenes: $e';
    }
  }

  void setDir(String value) {
    dir.value = value;
    storage.dir = value;
    _loadImages();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
