import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:fotoflu/controllers/galeria_controller.dart';

class Galeria extends StatelessWidget {
  Galeria({super.key});

  final controller = Get.find<GaleriaController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Obx(() {
        if (controller.images.isEmpty) {
          return Center(child: Text('No hay imágenes disponibles.'));
        } else {
          return PhotoViewGallery.builder(
            itemCount: controller.images.length,
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: FileImage(controller.images[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: BouncingScrollPhysics(),
            backgroundDecoration: BoxDecoration(color: Colors.black),
            pageController: PageController(),
          );
        }
      }),
    );
  }
}
