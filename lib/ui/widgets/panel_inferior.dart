import 'package:flutter/material.dart';
import 'package:fotoflu/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:fotoflu/controllers/panel_inferior_controller.dart';

class PanelInferior extends GetView<PanelInferiorController> {
  const PanelInferior({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Column(
        children: [
          _ControlesNavegacion(controller),
          _BarraNavegacion(controller),
        ],
      ),
    );
  }
}

class _ControlesNavegacion extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final PanelInferiorController controller;

  _ControlesNavegacion(this.controller);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Obx(
            () => IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed:
                  homeController.appState.value == AppState.explorando
                      ? () => controller.previousPage()
                      : null,
            ),
          ),
          Obx(
            () => IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed:
                  homeController.appState.value == AppState.explorando
                      ? () => controller.nextPage()
                      : null,
            ),
          ),
          Obx(
            () => IconButton(
              icon: const Icon(Icons.check),
              onPressed:
                  homeController.appState.value == AppState.explorando &&
                          homeController.cambioIdSelected.value != null
                      ? () => controller.seleccionar()
                      : null,
            ),
          ),
          Obx(
            () => IconButton(
              icon: const Icon(Icons.close),
              onPressed:
                  homeController.appState.value == AppState.explorando
                      ? () {}
                      : null,
            ),
          ),
          Obx(
            () => IconButton(
              icon: const Icon(Icons.delete),
              onPressed:
                  homeController.appState.value == AppState.explorando
                      ? () {}
                      : null,
            ),
          ),
          SizedBox(width: 20),
          SizedBox(
            height: 30,
            width: 200,
            child: TextField(
              readOnly: true,
              controller: controller.cambioEditing,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          SizedBox(width: 20),
          Obx(
            () => Text(
              controller.currentPage.value != null
                  ? (controller.currentPage.value! + 1).toInt().toString()
                  : '',
            ),
          ),
          Text('/'),
          Obx(() => Text(controller.maxImages.value.toString())),
          SizedBox(width: 20),
          Obx(() => Text(controller.nombreArchivo.value)),
        ],
      ),
    );
  }
}

class _BarraNavegacion extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final PanelInferiorController controller;

  _BarraNavegacion(this.controller);

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
                    controller.maxImages > 0
                        ? controller.maxImages.value.toDouble() - 1
                        : 0,
                value:
                    controller.currentPage.value! > -1
                        ? controller.currentPage.value!
                        : 0,
                onChanged: (double value) {
                  controller.goToPage(value.toInt());
                },
              ),
            );
          }
        },
      ),
    );
  }
}
