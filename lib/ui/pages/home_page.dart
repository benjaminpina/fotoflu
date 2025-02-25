import 'package:flutter/material.dart';
import 'package:fotoflu/controllers/galeria_controller.dart';
import 'package:fotoflu/controllers/home_controller.dart';
import 'package:fotoflu/ui/widgets/galeria.dart';
import 'package:fotoflu/ui/widgets/panel_inferior.dart';
import 'package:fotoflu/ui/widgets/panel_lateral.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  final galeriaController = Get.find<GaleriaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Row(
            children: [
              const Text('FotoFlu'),
              SizedBox(width: 20),
              Text(galeriaController.dir.value, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(child: Galeria()),
                SizedBox(height: 100, child: PanelInferior()),
              ],
            ),
          ),
          SizedBox(width: 300, height: double.infinity, child: PanelLateral()),
        ],
      ),
    );
  }
}
