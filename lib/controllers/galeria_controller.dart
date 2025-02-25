import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GaleriaController extends GetxController {
  final PageController pageController = PageController();

  var images = <File>[].obs;
  var currentPage = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPage.value = pageController.page ?? 0;
    });
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

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
