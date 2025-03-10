import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fotoflu/models/foto.dart';
import 'package:fotoflu/controllers/storage_controller.dart';

class GaleriaController extends GetxController {
  final storage = Get.find<StorageController>();
  final PageController pageController = PageController();

  var images = <Foto>[].obs;
  var maxImages = 0.obs;
  var currentPage = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPage.value = pageController.page ?? 0;
    });
  }

  void setImages(List<Foto> lista) async {
    images.clear();
    images.addAll(lista);
    maxImages.value = images.length;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
