import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GaleriaController extends GetxController {
  final PageController pageController = PageController();

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
