import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fotoflu/controllers/storage_controller.dart';
import 'package:get/get.dart';

class GaleriaController extends GetxController {
  final storage = Get.find<StorageController>();
  final PageController pageController = PageController();

  var images = <File>[].obs;
  var maxImages = 0.obs;
  var currentPage = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPage.value = pageController.page ?? 0;
    });
  }

  void setImages(List<String> lista) async {
    images.clear();
    images.addAll(lista.map((path) => File(path)));
    maxImages.value = images.length;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
