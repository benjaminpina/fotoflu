import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:fotoflu/controllers/galeria_controller.dart';
import 'package:fotoflu/controllers/panel_inferior_controller.dart';

class PanelInferior extends GetView<PanelInferiorController> {
  const PanelInferior({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Column(children: [_ControlesNavegacion(), _BarraNavegacion()]),
    );
  }
}

class _ControlesNavegacion extends StatelessWidget {
  final galeriaController = Get.find<GaleriaController>();
  final pageController = Get.find<GaleriaController>().pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (pageController.page! > 0) {
                pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              if (pageController.page! < galeriaController.images.length - 1) {
                pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
          IconButton(icon: const Icon(Icons.check), onPressed: () {}),
          IconButton(icon: const Icon(Icons.close), onPressed: () {}),
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
          SizedBox(width: 20),
          SizedBox(
            height: 30,
            width: 200,
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Cambio',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 20),
          Obx(
            () => Text(
              (galeriaController.currentPage.value + 1).toInt().toString(),
            ),
          ),
          Text(' de '),
          Obx(() => Text(galeriaController.maxImages.value.toString())),
          SizedBox(width: 20),
          Obx(
            () => Text(
              galeriaController.images.isNotEmpty
                  ? p.basename(
                    galeriaController
                        .images[galeriaController.currentPage.toInt()]
                        .path,
                  )
                  : '',
            ),
          ),
        ],
      ),
    );
  }
}

class _BarraNavegacion extends StatelessWidget {
  final galeriaController = Get.find<GaleriaController>();
  final pageController = Get.find<GaleriaController>().pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FutureBuilder(
        future: Future.delayed(
          Duration(milliseconds: 100),
        ), // Espera breve para asegurar que el PageView esté construido
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Obx(
              () => Slider(
                max:
                    galeriaController.maxImages > 0
                        ? galeriaController.maxImages.value.toDouble() - 1
                        : 0,
                value: galeriaController.currentPage.value,
                onChanged: (double value) {
                  pageController.jumpToPage(value.toInt());
                },
              ),
            );
          }
        },
      ),
    );
  }
}
